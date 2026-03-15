import 'package:hooks_riverpod/legacy.dart';

import 'domain/entities/user_entity.dart';

final loginIsLoadingProvider = StateProvider<bool>((ref) => false);
final loginErrorMessageProvider = StateProvider<String?>((ref) => null);
final authenticatedUserProvider = StateProvider<UserEntity?>((ref) => null);
