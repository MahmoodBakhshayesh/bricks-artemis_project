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
  final DeviceScreenType screenType;
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

enum DeviceScreenType {
  phone,
  tablet,
  desktop
}

extension DeviceTypeExt on DeviceScreenType {
  bool get isPhone => this == DeviceScreenType.phone;
  bool get isTablet => this == DeviceScreenType.tablet;
  bool get isDesktop => this == DeviceScreenType.desktop;
}