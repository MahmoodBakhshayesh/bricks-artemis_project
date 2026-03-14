import '../../di.dart';
import '../interfaces/base_config.dart';
import '../models/base/app_config.dart';

class ConfigService {
  static final ConfigService _instance = ConfigService._internal();

  static ConfigService get instance => _instance;

  ConfigService._internal();

  ConfigRepository get _repository => locator<ConfigRepository>();

  Future<AppConfig> loadConfig() => _repository.getMergedConfig();

  Future<void> saveUserConfig(AppConfig config) => _repository.saveUserOverride(config);

  Future<void> clearUserConfig() => _repository.clearUserOverride();
}
