import 'package:flutter/material.dart';
import '../../initialize.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomeViewPhone extends StatelessWidget {
  static HomeController myHomeController = getIt<HomeController>();
  const HomeViewPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home"),),
        backgroundColor: Colors.black54,
        body: Column(children: [

        ],));
  }
}

