import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../core/constants/ui.dart';
import '../core/navigation/navigation_service.dart';
import '../core/navigation/route_names.dart';
import '../core/navigation/router.dart';
import '../initialize.dart';
import 'DotButton.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppBarState();
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final router = ref.watch(routerProvider);
        RouteNames? currentRoute = RouteNames.values.firstWhereOrNull((element) => element.path == router.location);
        bool isSubroute = currentRoute == null;
        print(router.location);
        currentRoute ??= RouteNames.values.lastWhere((element) => router.location.contains("/${element.path}"));
        return Container(
          decoration: const BoxDecoration(color: MyColors.white1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: isSubroute
              ? DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                    child: Row(
                      children: [
                        DotButton(
                          icon: Icons.keyboard_arrow_left_sharp,
                          onPressed: () {
                            NavigationService ns = getIt<NavigationService>();
                            ns.pop();
                          },
                        ),
                        const SizedBox(width: 12),
                        ...RouteNames.values
                            .where((element) => router.location.split("/").contains(element.name))
                            .map((e) => DecoratedBox(
                                  decoration: const BoxDecoration(
                                    border:Border(right: BorderSide(color: MyColors.lightIshBlue, width: 4)) ,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0, top: 0),
                                    child: TextButton(
                                      onPressed: () {
                                        NavigationService ns = getIt<NavigationService>();
                                        ns.pushNamed(e);
                                      },
                                      child: Text(
                                        e.title,
                                        style: const TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()
                      ],
                    ),
                  ),
                )
              : Row(
                  children: [
                    IndexedStack(
                      index: 0,
                      children: [
                        const SizedBox(),
                        Row(
                          children: [
                            DotButton(
                              icon: Icons.keyboard_arrow_left_sharp,
                              onPressed: () {
                                NavigationService ns = getIt<NavigationService>();
                                ns.pop();
                              },
                            ),
                            const SizedBox(width: 12),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: RouteNames.values.where((element) => element.isMainRoute).map(
                        (e) {
                          bool selected = currentRoute == e;
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              border: selected ? const Border(bottom: BorderSide(color: MyColors.lightIshBlue, width: 4)) : const Border(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                              child: TextButton(
                                onPressed: () {
                                  NavigationService ns = getIt<NavigationService>();
                                  ns.pushNamed(e);
                                },
                                child: Text(
                                  e.title,
                                  style: const TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    )
                  ],
                ),
        );
      },
    );
  }
}
