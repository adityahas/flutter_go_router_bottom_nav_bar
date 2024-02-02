import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nested_navigation_gorouter_example/routes.dart';

void main() {
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
    final shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

    return MaterialApp.router(
      routerConfig: goRouter(
        rootNavigatorKey,
        shellNavigatorAKey,
        shellNavigatorBKey,
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
