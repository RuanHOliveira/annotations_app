import 'package:annotations_app/src/ui/core/themes/dark_mode.dart';
import 'package:annotations_app/src/ui/core/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _prefKey = 'THEME_MODE'; // 'L' ou 'D'

  ThemeData _themeData = lightMode;
  bool _loaded = false; // evita inicialização repetida

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;
  bool get isLoaded => _loaded;

  set themeData(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    // Alterna em memória
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();

    // Persiste
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, isDarkMode ? 'D' : 'L');
  }

  /// Carrega o tema salvo (chamar 1x no boot do app)
  Future<void> initializeTheme() async {
    if (_loaded) return; // idempotente

    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefKey) ?? 'L';

    _themeData = (saved == 'D') ? darkMode : lightMode;
    _loaded = true;
    notifyListeners();
  }

  /// Se quiser setar explicitamente
  Future<void> setDark(bool dark) async {
    _themeData = dark ? darkMode : lightMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, dark ? 'D' : 'L');
  }
}
