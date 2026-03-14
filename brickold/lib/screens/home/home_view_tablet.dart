import '../../initialize.dart';
import 'package:flutter/material.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomeViewTablet extends StatelessWidget {
  static HomeController myHomeController = getIt<HomeController>();

  const HomeViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        backgroundColor: Colors.black54,
        body: const Column(
          children: [],
        ));
  }
}
