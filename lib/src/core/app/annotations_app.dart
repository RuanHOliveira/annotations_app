import 'package:annotations_app/src/routing/router.dart';
import 'package:annotations_app/src/ui/core/themes/dark_mode.dart';
import 'package:annotations_app/src/ui/core/themes/light_mode.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class AnnotationsApp extends StatelessWidget {
  const AnnotationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Annotations',
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      builder: BotToastInit(),
      routerConfig: router,
    );
  }
}
