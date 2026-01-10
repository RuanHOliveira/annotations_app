import 'package:annotations_app/src/ui/core/themes/dark_mode.dart';
import 'package:annotations_app/src/ui/core/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  bool _loaded = false; // evita inicialização repetida

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;
  bool get isLoaded => _loaded;

  set themeData(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }

  // Altera tema
  Future<void> toggleTheme() async {
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();
  }

  /// Carrega o tema
  Future<void> initializeTheme() async {
    if (_loaded) return;
    _loaded = true;
    notifyListeners();
  }
}
