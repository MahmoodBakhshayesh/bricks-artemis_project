import 'package:flutter/material.dart';
import '../core/extensions/context_extension.dart';

class AppResponsive extends StatelessWidget {
  const AppResponsive({super.key, required this.mobileLayout, this.desktopLayout});

  final Widget mobileLayout;
  final Widget? desktopLayout;

  static bool isDesktop(BuildContext context) => context.width > DeviceBreakpoints.phoneMaxShortestSide;

  static bool isTablet(BuildContext context) =>
      context.width > DeviceBreakpoints.phoneMaxShortestSide && context.width < DeviceBreakpoints.desktopMinWidth;

  static T? responsive<T>(BuildContext context, {required T mobile, T? desktop}) {
    return isDesktop(context) ? desktop : mobile;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        late final Widget child;

        /// if the [Width] is bigger than [Height], then it should build [Desktop View]
        if (context.width > DeviceBreakpoints.phoneMaxShortestSide) {
          child = desktopLayout ?? mobileLayout;
        } else {
          child = mobileLayout;
        }

        return AnimatedSwitcher(duration: const Duration(milliseconds: 200), child: child);
      },
    );
  }
}
