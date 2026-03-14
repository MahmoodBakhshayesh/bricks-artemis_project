import 'app_config.dart';

/// The single, global instance of the app's flavor configuration.
///
/// This is initialized once in `main.dart` before the app runs.
late AppConfig appConfig;

//todo let's talk again
enum Flavor {
  production,
  dev;

  /// Returns the flavor set in run/build command with --dart-define=flavor=[Flavor].
  factory Flavor.fromString(String? flavorString) => Flavor.values.firstWhere((element) => element.name == flavorString);
}
