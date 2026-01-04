import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigClass extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  // Nova paleta de cores vibrante e moderna
  final Color _lightPrimary = const Color(0xFF6C5CE7); // Roxo vibrante
  final Color _lightSecondary = const Color(0xFF00D2D3); // Turquesa
  final Color _lightAccent = const Color(0xFFFF7675); // Coral
  final Color _lightBackground = const Color(0xFFF8F9FA); // Cinza muito claro
  final Color _lightSurface = Colors.white;

  final Color _darkPrimary = const Color(0xFFA29BFE); // Roxo claro
  final Color _darkSecondary = const Color(0xFF55EFC4); // Verde menta
  final Color _darkAccent = const Color(0xFFFF6B81); // Rosa
  final Color _darkBackground = const Color(0xFF2D3436); // Cinza escuro
  final Color _darkSurface = const Color(0xFF636E72); // Cinza médio

  Color get primaryColor => _isDark ? _darkPrimary : _lightPrimary;
  Color get secundaryColor => _isDark ? _darkSecondary : _lightSecondary;
  Color get accentColor => _isDark ? _darkAccent : _lightAccent;

  ConfigClass() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool("isDark") ?? false;
    notifyListeners();
  }

  Future<void> changeTheme() async {
    _isDark = !_isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", _isDark);
    notifyListeners();
  }

  ThemeData getThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _isDark ? _darkPrimary : _lightPrimary,
        secondary: _isDark ? _darkSecondary : _lightSecondary,
        tertiary: _isDark ? _darkAccent : _lightAccent,
        brightness: _isDark ? Brightness.dark : Brightness.light,
        surface: _isDark ? _darkSurface : _lightSurface,
      ),
      scaffoldBackgroundColor: _isDark ? _darkBackground : _lightBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: _isDark ? _darkSurface : _lightPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: _isDark ? _darkSurface : _lightSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _isDark ? _darkSurface.withOpacity(0.5) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: _isDark ? _darkSurface : Colors.grey.shade300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: _isDark ? _darkPrimary : _lightPrimary,
            width: 2,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
