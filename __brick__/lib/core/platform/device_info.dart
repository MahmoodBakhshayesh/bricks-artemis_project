import 'dart:io';
import 'package:artemis_utils/artemis_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import '../../initialize.dart';
import '../abstracts/device_info_service_abs.dart';
import '../navigation/navigation_service.dart';

class DeviceInfoService extends DeviceInfoServiceInterface {
  final MyDeviceInfo info;

  DeviceInfoService(this.info);

  @override
  DeviceInfo getInfo() {
    NavigationService navigationService = getIt<NavigationService>();
    BuildContext context = navigationService.context;
    ScreenType screenType = ScreenType.phone;
    if (Platform.isIOS || Platform.isAndroid) {
      if (context.isPhone) {
        screenType = ScreenType.phone;
      } else {
        screenType = ScreenType.tablet;
      }
    } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      screenType = ScreenType.desktop;
    }

    double comparingVersion = double.tryParse(info.versionNumber.replaceAll(".", ''))??0;
    return DeviceInfo(
      company: info.company,
      deviceModel: info.deviceModel,
      osVersion: info.osVersion,
      versionNumber: info.versionNumber,
      deviceKey: info.deviceKey,
      deviceType: info.deviceType,
      screenType: screenType,
      comparingVersion: comparingVersion,
    );
  }
}

// class DeviceInfo {
//   DeviceInfo._();
//
//
//   static DeviceType deviceType(BuildContext context) {
//     if(Platform.isIOS || Platform.isAndroid){
//       if(context.isPhone) {
//         return DeviceType.phone;
//       }else{
//         return DeviceType.tablet;
//       }
//     }else if(Platform.isWindows || Platform.isMacOS || Platform.isLinux){
//       return DeviceType.desktop;
//     }
//     return DeviceType.phone;
//   }
//
// }
