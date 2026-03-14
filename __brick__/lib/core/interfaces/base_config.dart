import 'dart:convert';

import 'package:flutter/services.dart';
import '../constants/assets.dart';
import '../constants/environment.dart';
import '../constants/keys.dart';
import '../data/app_data.dart';
import '../helpers/logger_service.dart';
import '../models/base/app_config.dart';
import 'base_key_value_store.dart';

abstract class ConfigLoader {
  Future<AppConfig?> load();
}

class AssetConfigLoader extends ConfigLoader {
  @override
  Future<AppConfig?> load() async {
    try {
      final jsonConfigString = await rootBundle.loadString(Assets.config, cache: false);
      final jsonConfig = jsonDecode(jsonConfigString);
      if (jsonConfig['flavor'] != null) {
        return AppConfig.fromJson(jsonConfig['flavor']);
      }
    } catch (e) {
      appLog.e(e.toString());
    }
    return null;
  }
}

class StorageConfigLoader {
  final BaseKeyValueStore _storage;

  StorageConfigLoader(this._storage);

  AppConfig? loadCached() {
    final cachedJson = _storage.get(Keys.appConfig);
    if (cachedJson != null) {
      try {
        return AppConfig.fromJson(jsonDecode(cachedJson));
      } catch (e) {
        appLog.e(e.toString());
      }
    }
    return null;
  }

  AppConfig? loadUser() {
    final userJson = _storage.get(Keys.userAppConfig);
    if (userJson != null) {
      try {
        return AppConfig.fromJson(jsonDecode(userJson));
      } catch (e) {
        appLog.e(e.toString());
      }
    }
    return null;
  }

  Future<void> saveCached(AppConfig config) async {
    await _storage.write(Keys.appConfig, jsonEncode(config.toJson()));
  }

  Future<void> saveUser(AppConfig config) async {
    await _storage.write(Keys.userAppConfig, jsonEncode(config.toJson()));
  }

  Future<void> clearUser() async {
    await _storage.remove(Keys.userAppConfig);
  }
}

/// if cached and asset loader failed, then at last resort use default config.
class DefaultConfigLoader extends ConfigLoader {
  @override
  Future<AppConfig?> load() async {
    return AppConfig(
      flavor: AppData.defaultFlavor,
      baseUrl: 'https://wbghmsapi.farateams.com',
      airlineLogoUrl: 'https://imagedcs.fdcs.ir/api/airlineimage/',
      hasServerSelect: true,
    );
  }
}

class ConfigRepository {
  final AssetConfigLoader _assetLoader;
  final StorageConfigLoader _storageLoader;
  final DefaultConfigLoader _defaultLoader;

  ConfigRepository(this._assetLoader, this._storageLoader, this._defaultLoader);

  Future<AppConfig> getMergedConfig() async {
    // 1. Fetch from sources (Loaders only return raw data)
    final assetConfig = await _assetLoader.load();
    if (assetConfig != null) {
      await _storageLoader.saveCached(assetConfig);
    }

    final cachedConfig = _storageLoader.loadCached();
    final userConfig = _storageLoader.loadUser();
    final defaultConfig = (await _defaultLoader.load())!;

    // 2. Authoritative Merge Logic (Single source of truth for priority)
    // Priority: Remote/Asset > Cached Asset > Default
    AppConfig finalConfig = assetConfig ?? cachedConfig ?? defaultConfig;

    // 3. Apply User Overrides
    if (userConfig != null) {
      finalConfig = finalConfig.copyWith(baseUrl: userConfig.baseUrl);
    }

    // 4. Apply Environment Overrides (Repository layer override)
    if (Environment.baseUrl.isNotEmpty) {
      finalConfig = finalConfig.copyWith(baseUrl: Environment.baseUrl);
    }

    return finalConfig;
  }

  Future<void> saveUserOverride(AppConfig config) async {
    await _storageLoader.saveUser(config);
  }

  Future<void> clearUserOverride() async {
    await _storageLoader.clearUser();
  }
}
