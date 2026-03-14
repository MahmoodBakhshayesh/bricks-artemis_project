import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../navigation/router.dart';
import '../navigation/routes.dart';
import 'controller_int.dart';

const String popUpNameAndKeySeparator = '@';

abstract class NavigationInterface {
  List<String> openedDialogOrBottomSheetList = [];
  List<String> openedDialogList = [];
  List<String> openedBottomSheetList = [];
  Map<RouteName, ControllerInterface> registeredControllers = {};
  List<RouteName> stack = [];
  Function? pendingRouteFunction;
  RouteName? previousRoute;

  RouteName? get currentRoute => RouteProvider.of(context);

  set _currentRoute(RouteName? newRoute) {
    RouteProvider.updateRoute(context: context, routeName: newRoute);
  }

  void registerAllControllers(Map<RouteName, ControllerInterface> routeToController) {
    registeredControllers = routeToController;
  }

  void initializeRoute(RouteName routeName, {bool addToStack = true}) {
    registeredControllers[routeName]?.onInit();
    if (addToStack) {
      stack.add(routeName);
    }
    _currentRoute = routeName;
  }

  void disposeRoute({required RouteName? previousRoute, required RouteName poppedRoute, bool updateStack = true}) {
    registeredControllers[poppedRoute]?.onDispose();
    if (updateStack && stack.isNotEmpty) {
      stack.removeLast();
    }
    _currentRoute = previousRoute;
  }

  BuildContext get context {
    return wrapper2Key.currentContext ?? wrapperKey.currentContext ?? navigationKey.currentContext!;
  }

  void goNamed(
    RouteName route, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    if (pendingRouteFunction != null) {
      pendingRouteFunction!();
      return;
    }
  }

  Future<T?> openDialog<T>({
    required Widget dialog,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    TraversalEdgeBehavior? traversalEdgeBehavior,
  });

  Future<T?> openBottomSheet<T>({
    required Widget bottomSheet,
    Color? backgroundColor,
    String? barrierLabel,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
  });

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> openSnackBar(SnackBar content);

  CancelFunc showTextToast({
    required String text,
  });

  void openDrawer();

  RouteName? pop({dynamic result});

  bool get isDialogOpen => openedDialogList.isNotEmpty;

  bool get isBottomSheetOpen => openedBottomSheetList.isNotEmpty;

  bool get isDialogOrBottomSheetOpen => openedDialogOrBottomSheetList.isNotEmpty;

  void popAllDialogs({dynamic result}) {
    while (isDialogOpen) {
      pop(result: result);
      String last = openedDialogOrBottomSheetList.removeLast();
      bool isDialog = openedDialogList.contains(last);
      if (isDialog) {
        openedDialogList.remove(last);
      }
    }
  }

  void popAllBottomSheets({dynamic result}) {
    while (isBottomSheetOpen) {
      pop(result: result);
      String last = openedDialogOrBottomSheetList.removeLast();
      bool isBottomSheet = openedBottomSheetList.contains(last);
      if (isBottomSheet) {
        openedBottomSheetList.remove(last);
      }
    }
  }

  void popAllPopUps({dynamic result}) {
    while (openedDialogOrBottomSheetList.isNotEmpty) {
      _popLastDialogOrBottomSheet(result: result);
    }
  }

  void _popLastDialogOrBottomSheet({dynamic result}) {
    pop(result: result);
    String last = openedDialogOrBottomSheetList.removeLast();
    bool isBottomSheet = openedBottomSheetList.contains(last);
    if (isBottomSheet) {
      openedBottomSheetList.remove(last);
    } else {
      openedDialogList.remove(last);
    }
  }

  void popUntilRoute({required bool Function(RouteName) verifyCondition}) async {
    popAllPopUps();
    RouteName? previousRoute;
    do {
      previousRoute = pop();
    } while (previousRoute == null ? false : !verifyCondition(previousRoute));
  }

  void popUntilPopUp({required bool Function(String) verifyCondition, dynamic result}) {
    if (openedDialogOrBottomSheetList.isEmpty) return;

    String storedPopUpName = '';
    do {
      _popLastDialogOrBottomSheet(result: result);
      storedPopUpName = _getPopUpNameFromRegisteredString(popUpNameAndKey: openedDialogOrBottomSheetList.last);
    } while (!verifyCondition(storedPopUpName));
  }

  bool canPopUntilPopUp({required String popUpName}) {
    if (openedDialogOrBottomSheetList.isEmpty) return false;

    //use sublist to skip checking the last one. it pops anyway even if it is equal to the input
    bool nameIsInDialogsOrBottomSheets = openedDialogOrBottomSheetList
        .sublist(0, openedDialogOrBottomSheetList.length - 1)
        .any((element) => _getPopUpNameFromRegisteredString(popUpNameAndKey: element) == popUpName);

    return nameIsInDialogsOrBottomSheets;
  }

  void registerPopUp({
    required String runtimeType,
    required bool isDialog,
    Key? key,
  }) {
    String popUpNameAndKey = createPopUpNameAndKeyString(name: runtimeType, key: key);
    _addPopUpNameAndKey(popUpNameAndKey: popUpNameAndKey, isDialog: isDialog);
  }

  void _addPopUpNameAndKey({required String popUpNameAndKey, required bool isDialog}) {
    openedDialogOrBottomSheetList.add(popUpNameAndKey);
    if (isDialog) {
      openedDialogList.add(popUpNameAndKey);
    } else {
      openedBottomSheetList.add(popUpNameAndKey);
    }
  }

  void removePopUpNameAndKey({required String nameAndKey, required bool isDialog}) {
    openedDialogOrBottomSheetList.remove(nameAndKey);
    if (isDialog) {
      openedDialogList.remove(nameAndKey);
    } else {
      openedBottomSheetList.remove(nameAndKey);
    }
  }

  String createPopUpNameAndKeyString({required String name, Key? key}) {
    String keyString = (key ?? UniqueKey()).toString();
    return "$name$popUpNameAndKeySeparator$keyString";
  }

  String _getPopUpNameFromRegisteredString({required String popUpNameAndKey}) {
    List<String> popUpStringParts = popUpNameAndKey.split(popUpNameAndKeySeparator);
    return popUpStringParts.first;
  }

  ///The alignment priority is higher than the others.
  ///To remove an overlay use the following code:
  ///overlayEntry.remove();
  ///overlayEntry.dispose();
  OverlayEntry showOverlay<T>({
    required Widget child,
    Alignment? alignment,
    double? fromTop,
    double? fromBottom,
    double? fromRight,
    double? fromLeft,
    bool canSizeOverlay = false,
    bool maintainState = false,
    bool opaque = false,
  }) {
    OverlayEntry overlayEntry = OverlayEntry(
      canSizeOverlay: canSizeOverlay,
      maintainState: maintainState,
      opaque: opaque,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: fromTop,
              bottom: fromBottom,
              right: fromRight,
              left: fromLeft,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  alignment: alignment,
                  // color: Colors.red,
                  child: child,
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context, debugRequiredFor: child).insert(overlayEntry);
    return overlayEntry;
  }
}

class RouteProvider extends InheritedNotifier<_RouteNameNotifier> {
  const RouteProvider._({
    super.key,
    super.notifier,
    required super.child,
  });

  factory RouteProvider({Key? key, required Widget child}) {
    return RouteProvider._(
      key: key,
      notifier: _RouteNameNotifier.instance,
      child: child,
    );
  }

  static RouteName? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RouteProvider>()!.notifier!.value;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<_RouteNameNotifier> oldWidget) {
    return notifier!.value != oldWidget.notifier!.value;
  }

  static updateRoute({required BuildContext context, required RouteName? routeName}) {
    _RouteNameNotifier.instance.updateRoute(newRoute: routeName);
  }
}

class _RouteNameNotifier extends ChangeNotifier {
  RouteName? value;

  _RouteNameNotifier._({required this.value});

  static final _RouteNameNotifier instance = _RouteNameNotifier._(value: null);

  void updateRoute({required RouteName? newRoute}) {
    if (value != newRoute) {
      value = newRoute;
      notifyListeners();
    }
  }
}
