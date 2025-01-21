import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masonCheck/core/extenstions/context_exp.dart';

class MyColors {
  MyColors._();

  static const mainColor = Color(0xff001b94);
  static const scaffoldBg = Color(0xfff0f1f3);
  static const shade = Color.fromRGBO(0,0,0,0.12);
  static const darkSlateBlue = Color(0xff133159);
  static const slateBlue = Color(0xff5f7b98);
  static const greyBG = Color(0xffeaeaea);
  static const white1 = Color.fromRGBO(245, 245, 245, 1);
  static const white2 = Color.fromRGBO(250, 250, 250, 1);
  static const white3 = Color.fromRGBO(255, 255, 255, 1);
  static const white4 = Color.fromRGBO(250, 250, 250, 1);
  static const white5 = Color.fromRGBO(247, 247, 247, 1);
  static const white6 = Color.fromRGBO(237, 237, 237, 1);
  static const black1 = Color.fromRGBO(52, 52, 52, 1);
  static const black2 = Color(0xFF0a1a3a);
  static const black = Color.fromRGBO(59, 59, 59, 1);
  static const notImportant = Color(0xffb9b9b9);
  static const disable = Color.fromRGBO(245, 245, 245, 0.5);
  static const black3 = Color.fromRGBO(59, 59, 59, 0.8);
  static const black7 = Color.fromRGBO(0, 0, 0, 0.07);
  static const black8 = Color.fromRGBO(0, 0, 0, 0.08);
  static const blueGreen = Color.fromRGBO(20, 122, 137, 1);
  static const printBlue = Colors.blueAccent;
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
  static const lightGreen = Color(0xffdce6e3);
  static const lightPeach = Color.fromRGBO(255, 204, 177, 1);
  static const greenishBeige = Color.fromRGBO(208, 204, 114, 1);
  static const eggshell = Color.fromRGBO(244, 243, 225, 1);
  static const dullOrange = Color.fromRGBO(217, 152, 65, 1);
  static const orange = Color(0xffF57B00);
  static const lightOrange = Color(0xffFFeddc);
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
  static const veryLightRed = Color(0xfffff2f2);
  static const veryLightPink = Color.fromRGBO(237, 237, 237, 1);
  static const veryLightPink2 = Color.fromRGBO(234, 234, 234, 1);
  static const veryLightPink3 = Color.fromRGBO(235, 235, 235, 1);
  static const veryLightPink4 = Color.fromRGBO(242, 242, 242, 1);
  static const veryLightPink5 = Color.fromRGBO(195, 195, 195, 1);
  static const veryLightPink6 = Color.fromRGBO(225, 225, 225, 1);
  static const veryLightPink7 = Color.fromRGBO(255, 238, 237, 1);
  static const greenishTeal = Color.fromRGBO(46, 198, 157, 1);
  static const green = Color.fromRGBO(106, 240, 29, 1);
  static const green2 = Color(0xff2fc488);
  static const macAndCheese = Color.fromRGBO(239, 176, 75, 1);
  static const oceanGreen = Color.fromRGBO(48, 141, 117, 1);
  static const butterscotch = Color.fromRGBO(239, 176, 75, 1);
  static const turquoise = Color.fromRGBO(10, 195, 159, 1);
  static const grapefruit = Color.fromRGBO(255, 93, 93, 1);
  static const red = Color.fromRGBO(238, 91, 92, 1);
  static const shinyRed = Color(0xfffa3030);
  static const lineColor = Color(0xffE1E1E1);
  static const lineBorderColor = Color.fromRGBO(0, 0, 0, 0.12);
  static const liveBG = Color(0xffF0F1f3);
  static const fadedBlue = Color(0xff7c8ac9);
  static const duskBlue = Color(0xff293a84);
  static const lightPeriwinkle = Color(0xffbdcaff);
  static const ice = Color.fromRGBO(218, 250, 246, 1);
  static const iceBlue = Color.fromRGBO(248, 255, 253, 1);
  static const havaPrime = Color.fromRGBO(229, 20, 100, 1);
  static const havaAccent = Color.fromRGBO(102, 196, 189, 1);
  static const warmGrey = Color.fromRGBO(131, 131, 131, 1);
  static const adl = Color.fromRGBO(77, 111, 255, 1);
  static const inf = Color.fromRGBO(222, 125, 13, 1);
  static const chd = Color.fromRGBO(230, 50, 133, 1);
  static const autoSeat = Color.fromRGBO(252, 90, 15, 1);
  static const manualSeat = Color.fromRGBO(25, 163, 7, 1);
  static const paxGrey = Color(0xffB9b9b9);
  static const checkinGreen = Color.fromRGBO(72, 192, 162, 1);
  static const boardingBlue = Color.fromRGBO(77, 111, 255, 1);
  static const reserveGreen = Color.fromRGBO(176, 255, 223, 1);
  static const evenRow = Color(0xfff8f8f8);
  static const oddRow = Color(0xffffffff);
  static const indexColor = Color(0xff3b3b3b);
  static const travelDocColor = Color.fromARGB(100, 200, 100, 250);
  static const darkRed = Color.fromRGBO(200, 0, 0, 1.0);

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

  static ThemeData lightAbomis(BuildContext con) => ThemeData(
    useMaterial3: true,
    // fontFamily: "OpenSans",
    primaryColor: MyColors.mainColor,
    canvasColor: Colors.transparent,
    brightness: Brightness.light,
    disabledColor: MyColors.brownGrey,
    dialogTheme: DialogTheme(
        insetPadding: EdgeInsets.symmetric(horizontal: con.isDesktop?con.width*0.3:12)
    ),
    scaffoldBackgroundColor: MyColors.scaffoldBg,
    tabBarTheme: TabBarTheme(labelPadding: EdgeInsets.zero, labelColor: Colors.blue, unselectedLabelColor: Colors.blue.withOpacity(0.5)),
    timePickerTheme: const TimePickerThemeData(),
    dividerTheme: const DividerThemeData(color: MyColors.lineColor, indent: 1, space: 1),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColors.white1),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: MyColors.white1, statusBarBrightness: Brightness.dark),
      backgroundColor: MyColors.white1,
      iconTheme: IconThemeData(color: MyColors.slateBlue),
    ),
    // fontFamily: "OpenSans",
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 18, color: MyColors.black, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 18, color: MyColors.black, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 16, color: MyColors.black),
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: MyColors.black),
      displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: MyColors.black),
      displaySmall: TextStyle(fontSize: 20, color: MyColors.black),
      titleLarge: TextStyle(fontSize: 14, color: MyColors.black),
      titleMedium: TextStyle(fontSize: 14, color: MyColors.black),
      titleSmall: TextStyle(fontSize: 14, color: MyColors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        backgroundColor: MyColors.lightIshBlue,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        foregroundColor: MyColors.lightIshBlue,
        side: const BorderSide(color: MyColors.lightIshBlue, width: 2),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(
        0xFF4d6fff,
        MyColors.materialColor,
      ),
    ).copyWith(
      secondary: MyColors.darkMint,
      primary: MyColors.mainColor,
    ),
    dataTableTheme: const DataTableThemeData(
      headingRowHeight: 35,
      dataRowMaxHeight: 40,
      columnSpacing: 4,
    ),
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(side: BorderSide(color: MyColors.lineColor)),
    ),
  );
}

class TextStyles {
  TextStyles._();

  static const styleBold24Black = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff424242));
  static const styleBold18Black = TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black);
  static const styleBold16Grey = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff808080));
  static const styleBold16Black = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.black1);
  static const styleBold12Black = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: MyColors.black2);
  static const style16Grey = TextStyle(fontSize: 16, color: Color(0xff808080), fontWeight: FontWeight.w300);
  static const tagListHeader = TextStyle(fontWeight: FontWeight.bold, fontSize: 13);
  static const appBarTitle = TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18);
}
