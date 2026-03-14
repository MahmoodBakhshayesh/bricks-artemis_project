import 'login_controller.dart';
import 'login_state.dart';
import 'login_view_phone.dart';
import 'login_view_tablet.dart';
import 'login_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class LoginView extends ConsumerWidget {
    const LoginView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return LoginViewDesktop();
      }else if(context.isMyTablet){
        return LoginViewTablet();
      }else{
        return LoginViewPhone();
      }
    }
}

