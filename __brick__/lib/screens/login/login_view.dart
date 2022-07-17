import 'dart:ffi';
import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import '../../core/constants/route_names.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../core/util/shortcuts/app_shortcuts.dart';
import 'login_controller.dart';
import 'login_state.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final LoginController loginController = getIt<LoginController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    LoginState loginState = context.watch<LoginState>();
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [const Spacer(), LoginPanel()],
        ),
      ),
    );
  }
}

class LoginPanel extends StatelessWidget {
  LoginPanel({Key? key}) : super(key: key);
  final LoginController loginController = getIt<LoginController>();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    LoginState loginState = context.watch<LoginState>();
    double width = Get.width;
    double height = Get.height;
    return Container(
      height: height,
      width: width*0.2,

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login",style: theme.textTheme.headline1),
                const SizedBox(height: 24),
                CupertinoTextField(
                  controller: loginState.usernameC,
                  placeholder: "Username",
                ),
                const SizedBox(height: 24),
                CupertinoTextField(
                  obscureText: !loginState.showPassword,
                  controller: loginState.passwordC,
                  placeholder: "Password",
                  suffix: IconButton(
                    icon: Icon(!loginState.showPassword?Ionicons.eye:Ionicons.eye_off),
                    onPressed: (){
                      loginState.showPassword = !loginState.showPassword;
                      loginState.setState();
                    },
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: Get.width,
                  height: 40,
                  child: ArtemisButton(

                    backgroundColor: theme.primaryColor,
                    color: Colors.white,
                    label: "Login",
                    isLoading: loginState.loginLoading,
                    onPressed: (){
                      loginController.login(username: loginState.usernameC.text, password: loginState.passwordC.text);
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
