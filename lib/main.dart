// This is your app. It runs as it is: press run and you get the screen below.
//
// Nothing here is precious. Change the title, change the colors, delete the
// counter, add your own screens. It exists so that the repository is a working
// Flutter app from minute one instead of an empty folder.
//
// Everything in this file is Module 4 and 5 material: StatelessWidget,
// StatefulWidget, setState, Scaffold, AppBar, Column, Card, FilledButton.

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'utils/hive_loader.dart';
import 'theme/app_theme.dart';
import 'screens/root.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await HiveLoader.init();

  runApp(
    // DevicePreview draws a phone frame around your app, so it is judged at the
    // size it was designed for instead of stretched across a laptop window.
    //
    // It is left ON in the deployed build on purpose: your live link is opened
    // on a desktop browser, and a phone layout at full desktop width looks
    // broken when it is not. The toolbar also lets a visitor switch device and
    // orientation.
    //
    // Want the clean app with no frame instead (for a portfolio, or because
    // you made the layout properly responsive)? Add
    //   import 'package:flutter/foundation.dart' show kReleaseMode;
    // and set `enabled: !kReleaseMode`, which drops the frame in release builds.
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Final Project',
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),

      // These two lines are what make the DevicePreview toolbar actually
      // change the app. Keep them.
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      // Your design system starts here. One seed color generates a full
      // Material palette; swap in your own and every screen follows.
      theme: AppTheme.light,

      home: const Root(),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}