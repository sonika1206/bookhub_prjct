import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  static const String _themeKey = 'themeMode';
  static const String _boxName = 'settings';
  late Box _box;

  ThemeModeNotifier() : super(ThemeMode.light) {
    _initHive();
  }

  Future<void> _initHive() async {
    try {
      _box = await Hive.openBox(_boxName);
      _loadTheme();
    } catch (e) {
      print('Error initializing Hive: $e'); 
    }
  }

  Future<void> _loadTheme() async {
    try {
      final themeString = _box.get(_themeKey) as String?;
      if (themeString != null) {
        state = themeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
      }
      print('Loaded theme from Hive: ${state == ThemeMode.dark ? "dark" : "light"}'); 
    } catch (e) {
      print('Error loading theme from Hive: $e'); 
    }
  }

  Future<void> toggleTheme() async {
    try {
      state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      await _box.put(_themeKey, state == ThemeMode.dark ? 'dark' : 'light');
      print('Toggled theme to: ${state == ThemeMode.dark ? "dark" : "light"}');
    } catch (e) {
      print('Error saving theme to Hive: $e'); 
    }
  }
}