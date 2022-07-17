import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyColors {
  MyColors._();

  static const mainColor = Color(0xff133159);
  static const darkSlateBlue = Color(0xff133159);
  static const slateBlue = Color(0xff5f7b98);
  static const white1 = Color.fromRGBO(245, 245, 245, 1);
  static const white2 = Color.fromRGBO(250, 250, 250, 1);
  static const white3 = Color.fromRGBO(255, 255, 255, 1);
  static const white4 = Color.fromRGBO(250, 250, 250, 1);
  static const white5 = Color.fromRGBO(247, 247, 247, 1);
  static const white6 = Color.fromRGBO(237, 237, 237, 1);
  static const black1 = Color.fromRGBO(52, 52, 52, 1);
  static const black = Color.fromRGBO(59, 59, 59, 1);
  static const black3 = Color.fromRGBO(59, 59, 59, 0.8);
  static const black7 = Color.fromRGBO(0, 0, 0, 0.07);
  static const black8 = Color.fromRGBO(0, 0, 0, 0.08);
  static const blueGreen = Color.fromRGBO(20, 122, 137, 1);
  static const adobe = Color.fromRGBO(186, 112, 72, 1);
  static const oliveDrab = Color.fromRGBO(111, 108, 46, 1);
  static const paleGrey2 = Color.fromRGBO(247, 248, 255, 1);
  static const paleGrey = Color.fromRGBO(226, 240, 237, 1);
  static const greyishBrown = Color(0xff484848);
  static const greyBlue = Color.fromRGBO(129, 185, 171, 1);
  static const paleGreyTwo = Color.fromRGBO(239, 249, 255, 1);
  static const lightIshBlue = Color.fromRGBO(77, 111, 255, 1);
  static const veryLightBlue = Color.fromRGBO(230, 236, 255, 1);
  static const lightBlue = Color.fromRGBO(142, 219, 230, 1);
  static const lightBlueGrey = Color(0xffcbd1d8);
  static const lightPeach = Color.fromRGBO(255, 204, 177, 1);
  static const greenishBeige = Color.fromRGBO(208, 204, 114, 1);
  static const eggshell = Color.fromRGBO(244, 243, 225, 1);
  static const dullOrange = Color.fromRGBO(217, 152, 65, 1);
  static const aquaMarine = Color.fromRGBO(77, 204, 182, 0.1);
  static const darkMint = Color.fromRGBO(72, 192, 162, 1);
  static const brownGrey = Color.fromRGBO(141, 141, 141, 1);
  static const brownGrey2 = Color.fromRGBO(134, 134, 134, 1);
  static const brownGrey3 = Color.fromRGBO(173, 173, 173, 1);
  static const brownGrey4 = Color.fromRGBO(170, 170, 170, 1);
  static const brownGrey5 = Color.fromRGBO(130, 130, 130, 1);
  static const brownGrey6 = Color.fromRGBO(178, 178, 178, 1);
  static const brownGrey7 = Color.fromRGBO(175, 175, 175, 1);
  static const pinkishGrey = Color.fromRGBO(206, 206, 206, 1);
  static const paleGreyThree = Color.fromRGBO(241, 244, 255, 1);
  static const veryLightPink = Color.fromRGBO(237, 237, 237, 1);
  static const veryLightPink2 = Color.fromRGBO(234, 234, 234, 1);
  static const veryLightPink3 = Color.fromRGBO(235, 235, 235, 1);
  static const veryLightPink4 = Color.fromRGBO(242, 242, 242, 1);
  static const veryLightPink5 = Color.fromRGBO(195, 195, 195, 1);
  static const veryLightPink6 = Color.fromRGBO(225, 225, 225, 1);
  static const veryLightPink7 = Color.fromRGBO(255, 238, 237, 1);
  static const greenishTeal = Color.fromRGBO(46, 198, 157, 1);
  static const green = Color.fromRGBO(106, 240, 29, 1);
  static const oceanGreen = Color.fromRGBO(48, 141, 117, 1);
  static const butterscotch = Color.fromRGBO(239, 176, 75, 1);
  static const turquoise = Color.fromRGBO(10, 195, 159, 1);
  static const grapefruit = Color.fromRGBO(255, 93, 93, 1);
  static const red = Color.fromRGBO(238, 91, 92, 1);
  static const lineColor = Color(0xffE1E1E1);
  static const ice = Color.fromRGBO(218, 250, 246, 1);
  static const iceBlue = Color.fromRGBO(248, 255, 253, 1);
  static const havaPrime = Color.fromRGBO(229, 20, 100, 1);
  static const havaAccent = Color.fromRGBO(102, 196, 189, 1);
  static const warmGrey = Color.fromRGBO(131, 131, 131, 1);
  static const adl = Color.fromRGBO(77, 111, 255, 1);
  static const chd = Color.fromRGBO(222, 125, 13, 1);
  static const inf = Color.fromRGBO(230, 50, 133, 1);
  static const autoSeat = Color.fromRGBO(252, 90, 15, 1);
  static const manualSeat = Color.fromRGBO(25, 163, 7, 1);

  static const materialColor = {
    50: Color.fromRGBO(77, 111, 255, .1),
    100: Color.fromRGBO(77, 111, 255, .2),
    200: Color.fromRGBO(77, 111, 255, .3),
    300: Color.fromRGBO(77, 111, 255, .4),
    400: Color.fromRGBO(77, 111, 255, .5),
    500: Color.fromRGBO(77, 111, 255, .6),
    600: Color.fromRGBO(77, 111, 255, .7),
    700: Color.fromRGBO(77, 111, 255, .8),
    800: Color.fromRGBO(77, 111, 255, .9),
    900: Color.fromRGBO(77, 111, 255, 1),
  };
}

class MyTheme {
  MyTheme._();

  static ThemeData light = ThemeData(
      fontFamily: "OpenSans",
      primaryColor: MyColors.mainColor,
      canvasColor: Colors.transparent,
      brightness: Brightness.light,
      disabledColor: MyColors.brownGrey,
      scaffoldBackgroundColor: Colors.white,
      timePickerTheme: const TimePickerThemeData(),
      dividerTheme: const DividerThemeData(color: MyColors.lineColor, indent: 1, space: 1),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColors.white1),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: MyColors.mainColor, statusBarBrightness: Brightness.dark),
        backgroundColor: MyColors.mainColor,
        iconTheme: IconThemeData(color: MyColors.slateBlue),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColors.black),
        headline2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: MyColors.black),
        headline3: TextStyle(fontSize: 20, color: MyColors.black),
        headline4: TextStyle(fontSize: 18, color: MyColors.black, fontWeight: FontWeight.bold),
        headline5: TextStyle(fontSize: 16, color: MyColors.black),
        headline6: TextStyle(fontSize: 14, color: MyColors.black),
        subtitle1: TextStyle(fontSize: 12, color: MyColors.black),
        subtitle2: TextStyle(fontSize: 10, color: MyColors.black),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              backgroundColor: MyColors.lightIshBlue,
              primary: Colors.white)),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              primary: MyColors.lightIshBlue,
              side: const BorderSide(color: MyColors.lightIshBlue, width: 2))),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: const MaterialColor(0xFF4d6fff, MyColors.materialColor)).copyWith(
        secondary: MyColors.darkMint,
        primary: MyColors.mainColor,
      ),
      dataTableTheme: const DataTableThemeData(headingRowHeight: 35, dataRowHeight: 40, columnSpacing: 4));

  static ThemeData dark = ThemeData(
    fontFamily: "OpenSans",
    primaryColor: Colors.deepPurple,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      primary: Colors.deepOrange,
    )),
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.deepPurple, secondary: Colors.grey),
  );
}
