import '../../initialize.dart';
import '../../widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomeViewDesktop extends StatelessWidget {
  static HomeController myHomeController = getIt<HomeController>();
  const HomeViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: MyAppBar(),
        body: Column(children: [

        ],));
  }
}

