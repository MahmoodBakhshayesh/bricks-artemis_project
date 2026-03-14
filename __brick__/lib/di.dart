import 'package:get_it/get_it.dart';
import 'core/constants/keys.dart';
import 'core/data/app_data.dart';
import 'core/database/object_box.dart';
import 'core/helpers/api_service.dart';
import 'core/helpers/app_overlays_helper.dart';
import 'core/helpers/go_router_helper.dart';
import 'core/helpers/logger_service.dart';
import 'core/helpers/shared_preferences_helper.dart';
import 'core/interfaces/base_config.dart';
import 'core/interfaces/base_key_value_store.dart';
import 'core/interfaces/base_navigation_service.dart';
import 'core/interfaces/base_overlays_helper.dart';
import 'core/models/base/flavor_config.dart';
import 'core/services/config_service.dart';
import 'features/flights/domain/data_sources/flights_local_data_source.dart';
import 'features/flights/domain/data_sources/flights_remote_data_source.dart';
import 'features/flights/domain/interfaces/flights_data_source_interface.dart';
import 'features/flights/domain/interfaces/flights_repository_interface.dart';
import 'features/flights/domain/repositories/flights_repository.dart';
import 'features/flights/usecases/get_flight_details_usecase.dart';
import 'features/flights/usecases/get_flights_usecase.dart';
import 'features/login/domain/data_sources/login_local_data_source.dart';
import 'features/login/domain/data_sources/login_remote_data_source.dart';
import 'features/login/domain/interfaces/login_data_source_interface.dart';
import 'features/login/domain/interfaces/login_repository_interface.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/usecases/login_usecase.dart';

GetIt locator = GetIt.instance;

final sessionStorage = locator<BaseKeyValueStore>(instanceName: Keys.sessionStorageInstance);

LoggerService registerLoggerService() {
  return locator.registerSingleton(LoggerService());
}

Future<void> initializeStorages() async {
  return registerStorage(locator);
}

Future<void> initObjectBox() async {
  ObjectBox objectBox = await ObjectBox.create();
  await seedDatabase(objectBox.store);
  locator.registerSingleton<ObjectBox>(objectBox);
}

/// Determine the flavor and initialize the config. This must be the first
/// step to ensure that all subsequent parts of the app can access it.
Future<void> initializeAppConfig({String? baseUrl}) async {
  final configService = ConfigService.instance;
  if (baseUrl != null) {
    final currentConfig = await configService.loadConfig();
    final userConfig = currentConfig.copyWith(baseUrl: baseUrl);
    await configService.saveUserConfig(userConfig);
  }

  appConfig = await configService.loadConfig();
}


void initializeDependencies() {
  /// Core Services
  locator.registerSingleton<BaseNavigationService>(GoRouterHelper());
  locator.registerLazySingleton<BaseOverlaysHelper>(() => AppOverlaysHelper());
  locator.registerLazySingleton<ApiService>(() => ApiService.appDefault());

  // --- Data Sources ---
  locator.registerLazySingleton<LoginDataSourceInterface>(() => LoginLocalDataSource(locator()), instanceName: 'LoginLocalDataSource');
  locator.registerLazySingleton<LoginDataSourceInterface>(() => LoginRemoteDataSource(locator()), instanceName: 'LoginRemoteDataSource');

  locator.registerLazySingleton<FlightsDataSourceInterface>(() => FlightsLocalDataSource(locator()), instanceName: 'FlightsLocalDataSource');
  locator.registerLazySingleton<FlightsDataSourceInterface>(() => FlightsRemoteDataSource(locator()), instanceName: 'FlightsRemoteDataSource');

  // --- Repositories ---
  locator.registerLazySingleton<LoginRepositoryInterface>(LoginRepository.builder);
  locator.registerLazySingleton<FlightsRepositoryInterface>(FlightsRepository.builder);

  // --- Use Cases ---
  locator.registerLazySingleton(() => LoginUsecase(locator()));
  locator.registerLazySingleton(() => GetFlightsUsecase(repository: locator()));
  locator.registerLazySingleton(() => GetFlightDetailsUsecase(repository: locator()));

}

Future<void> registerGlobalRepositories() async {

  /// Config Repository
  final storage = locator<BaseKeyValueStore>();
  locator.registerLazySingleton<ConfigRepository>(
        () => ConfigRepository(
      AssetConfigLoader(),
      StorageConfigLoader(storage),
      DefaultConfigLoader(),
    ),
  );
  await AppData.instance.init();
}
