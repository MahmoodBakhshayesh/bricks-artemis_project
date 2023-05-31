import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants/ui.dart';

class Spinners {
  Spinners._();
  static Widget get loadingSpinner=> const SpinKitThreeBounce(size: 20,color: Colors.white);
  static Widget get loadingSpinnerColor=> const SpinKitThreeBounce(size: 20,color: MyColors.lightIshBlue);
  static Widget get chasingDotsWhite=> const SpinKitChasingDots(size: 20,color: Colors.white);
  static Widget get spinner1=> const SpinKitChasingDots(color: Colors.blueAccent,size: 25);

}