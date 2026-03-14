import 'home_controller.dart';
import 'home_state.dart';
import 'home_view_phone.dart';
import 'home_view_tablet.dart';
import 'home_view_desktop.dart';
import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/extenstions/context_exp.dart';

class HomeView extends ConsumerWidget {
    const HomeView({super.key});
    @override
    Widget build(BuildContext context,WidgetRef ref) {
      if(context.isDesktop){
        return HomeViewDesktop();
      }else if(context.isMyTablet){
        return HomeViewTablet();
      }else{
        return HomeViewPhone();
      }
    }
}

