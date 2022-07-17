import 'package:artemis_ui_kit/artemis_ui_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import 'login_controller.dart';
import 'login_state.dart';

class LoginViewTablet extends StatelessWidget {
  LoginViewTablet({Key? key}) : super(key: key);
  final LoginController loginController = getIt<LoginController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    LoginState loginState = context.watch<LoginState>();
    double width = Get.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image.asset(AssetImages.loginHeader,width: width,fit: BoxFit.fitWidth,),
            LoginPanelTablet()],
        ),
      ),
    );
  }
}

class LoginPanelTablet extends StatelessWidget {
  LoginPanelTablet({Key? key}) : super(key: key);
  final LoginController loginController = getIt<LoginController>();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    LoginState loginState = context.watch<LoginState>();
    double width = Get.width;
    double height = Get.height;
    return Container(
      width: width*0.5,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.lineColor)
      ),
      child: SingleChildScrollView(
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
                    enabled: false,
                    controller: loginState.usernameC,
                    placeholder: "Airline",
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: loginState.usernameC,
                    placeholder: "Username",
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: loginState.passwordC,
                    placeholder: "Password",
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: (){}, child: const Text("Forget Password"),style: TextButton.styleFrom(
                      primary: theme.primaryColor,
                      backgroundColor: Colors.white
                    ),),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CupertinoSwitch(value: true, onChanged: (v){}),
                      const Text("Remember Me"),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
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
                      ),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
