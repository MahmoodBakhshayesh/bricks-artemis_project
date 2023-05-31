abstract class DeviceInfoServiceInterface {
  DeviceInfo getInfo();
}



class DeviceInfo {
  final String company;
  final String deviceModel;
  final String osVersion;
  final String versionNumber;
  final String deviceKey;
  final String deviceType;
  final ScreenType screenType;
  final double comparingVersion;

  DeviceInfo({
    required this.company,
    required this.deviceModel,
    required this.osVersion,
    required this.versionNumber,
    required this.deviceKey,
    required this.deviceType,
    required this.screenType,
    required this.comparingVersion,
  });


}

enum ScreenType {
  phone,
  tablet,
  desktop
}

extension DeviceTypeExt on ScreenType {
  bool get isPhone => this == ScreenType.phone;
  bool get isTablet => this == ScreenType.tablet;
  bool get isDesktop => this == ScreenType.desktop;
}