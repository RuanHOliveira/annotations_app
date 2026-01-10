import 'dart:async';
import 'package:annotations_app/src/config/providers/app_providers.dart';
import 'package:annotations_app/src/core/app/annotations_app.dart';
import 'package:annotations_app/src/data/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  // Captura exceções fora da árvore Flutter
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalDatabase.instance;
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    runApp(
      MultiProvider(providers: buildAppProviders(), child: AnnotationsApp()),
    );
  }, (error, stack) async {});
}
