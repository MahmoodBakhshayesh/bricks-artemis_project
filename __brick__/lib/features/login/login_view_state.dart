import 'package:hooks_riverpod/legacy.dart';
import '../../core/database/user/user_entity.dart';

final loginIsLoadingProvider = StateProvider<bool>((ref) => false);
final loginErrorMessageProvider = StateProvider<String?>((ref) => null);
final authenticatedUserProvider = StateProvider<UserEntity?>((ref) => null);
