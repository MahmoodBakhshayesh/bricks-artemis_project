import '../../core/constants/ui.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/MyButton.dart';
import '../../widgets/MyTextField.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginViewPhone extends StatelessWidget {
  static LoginController myLoginController = getIt<LoginController>();

  const LoginViewPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.black54, body: LoginPanel());
  }
}

class LoginPanel extends ConsumerWidget {
  static LoginController myLoginController = getIt<LoginController>();

  const LoginPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    LoginState state = ref.read(loginProvider);
    return Container(
      // width: 300,
      margin: const EdgeInsets.only(left: 24, right: 24, top: 72),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Please Login", style: TextStyles.styleBold16Black),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyTextField(
                label: "Username",
                controller: state.usernameC,
                focusNode: state.usernameFN,
                onSubmit: (v) {
                  print(v);
                  FocusScope.of(context).requestFocus(state.passwordFN);
                },
              ),
              const SizedBox(height: 24),
              MyTextField(
                label: "Password",
                controller: state.passwordC,
                focusNode: state.passwordFN,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  LoginState state = ref.watch(loginProvider);
                  return MyButton(
                    height: 45,
                    onPressed: () async {
                      await Future.delayed(const Duration(seconds: 2));
                    },
                    fontSize: 16,
                    label: 'Enter',
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
