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
    // Garante que todos os widgets estejam carregados antes de iniciar a execução
    WidgetsFlutterBinding.ensureInitialized();

    // Inicializar banco local
    await LocalDatabase.instance;

    // Define orientação preferencial do dispositivo (retrato)
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Iniciando app com providers
    runApp(
      MultiProvider(providers: buildAppProviders(), child: AnnotationsApp()),
    );
  }, (error, stack) async {});
}
