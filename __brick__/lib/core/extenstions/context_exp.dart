import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

extension BuldContextMore on BuildContext {
  bool get isMyTablet {
    if(isDesktop) return false;
    var size = MediaQuery.of(this).size;
    var diagonal = sqrt((size.width * size.width) + (size.height * size.height));

    var isTablet = diagonal > 1100.0;
    return isTablet;

    double width = MediaQuery.of(this).size.width;
    print(width);

    return (Platform.isIOS || Platform.isAndroid) && width > 600;
  }
  bool get isDesktop {
    return Platform.isMacOS || Platform.isWindows;
  }
  double get width {
    return MediaQuery.of(this).size.width;
  }
  EdgeInsets? get getDialogPadding {
    return EdgeInsets.symmetric(horizontal:isMyTablet?width*0.25: isDesktop?  width*.3:12);
  }
  EdgeInsets? get getBigDialogPadding {
    return EdgeInsets.symmetric(horizontal:isMyTablet?width*0.10: isDesktop?  width*.3:12);
  }
  EdgeInsets? get horizontalPadding {
    return EdgeInsets.symmetric(horizontal:isMyTablet?16: isDesktop?  16:12);
  }
  EdgeInsetsGeometry get getDrawerPadding {
    return EdgeInsets.all(isMyTablet?24: isDesktop?  24:16);
  }

  Color get mainColor => Theme.of(this).primaryColor;
}
