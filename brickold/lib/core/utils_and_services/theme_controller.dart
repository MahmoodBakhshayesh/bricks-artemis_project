import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_data.dart';

final themeProvider =
    StateProvider.autoDispose<ThemeData>((ref) => AppData.config?.theme == 'light' ? ThemeData.light() : ThemeData.dark());
