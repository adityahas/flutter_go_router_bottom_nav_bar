// part of 'main.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nested_navigation_gorouter_example/scaffold_with_nested_navigation.dart';
import 'package:nested_navigation_gorouter_example/screen/detail_screen.dart';
import 'package:nested_navigation_gorouter_example/screen/root_screen.dart';

goRouter(
  GlobalKey<NavigatorState>? rootNavigatorKey,
  GlobalKey<NavigatorState>? shellNavigatorAKey,
  GlobalKey<NavigatorState>? shellNavigatorBKey,
) {
  return GoRouter(
    initialLocation: '/a',
    // * Passing a navigatorKey causes an issue on hot reload:
    // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
    // * However it's still necessary otherwise the navigator pops back to
    // * root on hot reload
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: shellNavigatorAKey,
            routes: [
              GoRoute(
                path: '/a',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: RootScreen(label: 'A', detailsPath: '/a/details'),
                ),
                routes: [
                  GoRoute(
                    path: 'details',
                    builder: (context, state) =>
                        const DetailsScreen(label: 'A'),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorBKey,
            routes: [
              // Shopping Cart
              GoRoute(
                path: '/b',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: RootScreen(label: 'B', detailsPath: '/b/details'),
                ),
                routes: [
                  GoRoute(
                    path: 'details',
                    builder: (context, state) =>
                        const DetailsScreen(label: 'B'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
