import '../abstracts/device_info_service_abs.dart';
import '../classes/user_class.dart';
import 'config_class.dart';
import 'settings_class.dart';

class BasicClass {
  BasicClass._();

  factory BasicClass() {
    return instance;
  }

  static final BasicClass instance = BasicClass._();
  static late bool initialized;
  String? _username;
  Settings? _settings;
  User? _userInfo;

  // MyDeviceInfo? _deviceInfo;
  ScreenType? _deviceType;
  Config? _appConfig;

  // stConfig? get config=>_appConfig;

  static void initialize(Settings settings, ScreenType deviceType) {
    // instance._settings ??= settings;
    instance._settings = settings;
    instance._userInfo = settings.userSettings.userInfo;
    // instance._deviceInfo = deviceInfo;
    instance._deviceType = deviceType;
  }

  static void setConfig(Config config) {
    instance._appConfig = config;
  }

  static String get username => instance._username!;

  static Settings get settings => instance._settings ?? Settings.empty();

  static User get userInfo => instance._userInfo ?? User.empty();

  static Config get config => instance._appConfig ?? Config.def();

  // static MyDeviceInfo get deviceInfo => instance._deviceInfo??MyDeviceInfo();
  static ScreenType get deviceType => instance._deviceType ?? ScreenType.phone;
}
