import 'package:brs_panel/initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/MyButton.dart';
import '../../widgets/MyTextField.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginView extends StatelessWidget {
  static LoginController myLoginController = getIt<LoginController>();

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.black54,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LoginPanel(),
          ],
        ));
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
      width: 300,
      height: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        children: [
          const Text("Please Login"),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyTextField(
                  label: "Username",
                  controller: state.usernameC,
                  validator: (v) {
                    if (v.isEmpty) {
                      return null;
                    } else if (v.length < 4) {
                      return "Too Short";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 12),
                MyTextField(label: "Password", controller: state.passwordC),
                const SizedBox(height: 12),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    LoginState state = ref.watch(loginProvider);
                    return MyButton(
                      onPressed: () async {
                        await Future.delayed(const Duration(seconds: 2));
                      },
                      label: 'login',
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
