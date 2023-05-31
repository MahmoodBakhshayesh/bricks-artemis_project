import 'package:brs_panel/initialize.dart';
import 'package:brs_panel/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import '../../core/util/basic_class.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomeView extends StatelessWidget {
  static HomeController myHomeController = getIt<HomeController>();
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Column(children: [

        ],));
  }
}

