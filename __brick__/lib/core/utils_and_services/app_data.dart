import '../classes/config_class.dart';
import '../classes/user_class.dart';
import '../interfaces/device_info_service_int.dart';
import 'settings_class.dart';

class AppData {
  AppData._();

  factory AppData() {
    return instance;
  }

  static final AppData instance = AppData._();
  static late bool initialized;
  String? _username;
  Settings? _settings;
  User? _userInfo;
  String _token = "";

  // MyDeviceInfo? _deviceInfo;
  DeviceScreenType? _deviceType;
  Config? _appConfig;

  // stConfig? get config=>_appConfig;

  static void initialize(Settings settings, DeviceScreenType deviceType) {
    // instance._settings ??= settings;
    instance._settings = settings;
    instance._token = settings.userSettings.userInfo.token;
    instance._userInfo = settings.userSettings.userInfo;

    // instance._deviceInfo = deviceInfo;
    instance._deviceType = deviceType;
  }

  static void setConfig(Config config) {
    instance._appConfig = config;
  }

  static String get username => instance._username!;
  static String get token => instance._token!;

  static Settings get settings => instance._settings ?? Settings.empty();

  static User get userInfo => instance._userInfo ?? User.empty();

  static Config get config => instance._appConfig ?? Config.def();

  // static MyDeviceInfo get deviceInfo => instance._deviceInfo??MyDeviceInfo();
  static DeviceScreenType get deviceType => instance._deviceType ?? DeviceScreenType.phone;
}
