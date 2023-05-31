import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../initialize.dart';
import '../../screens/login/login_state.dart';

abstract class Request {
  final WidgetRef ref = getIt<WidgetRef>();
  final user = getIt<WidgetRef>().read(userProvider.notifier);
  Map<String,dynamic> toJson();

  String? get token => user.state?.token;
}