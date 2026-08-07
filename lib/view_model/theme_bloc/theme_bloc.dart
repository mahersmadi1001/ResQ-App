import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projct/view_model/theme_bloc/theme_event.dart';
import 'package:projct/view_model/theme_bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial()) {
    on<ThemeChanged>(_onThemeChanged);
    _loadInitialTheme();
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    emit(ThemeLoaded(isDarkMode: event.isDarkMode));
    _saveThemePreference(event.isDarkMode);
  }

  Future<void> _loadInitialTheme() async {
    try {
      final themeBox = await Hive.openBox('theme_box');
      final isDarkMode = themeBox.get('is_dark_mode') ?? false;
      add(ThemeChanged(isDarkMode: isDarkMode));
    } catch (e) {
      print('Error loading initial theme: $e');
      add(ThemeChanged(isDarkMode: false));
    }
  }

  Future<void> _saveThemePreference(bool isDarkMode) async {
    try {
      final themeBox = await Hive.openBox('theme_box');
      await themeBox.put('is_dark_mode', isDarkMode);
    } catch (e) {
      print('Error saving theme preference: $e');
    }
  }

  // Future<bool> loadThemePreference() async {
  //   try {
  //     final themeBox = await Hive.openBox('theme_box');
  //     return themeBox.get('is_dark_mode') ?? false;
  //   } catch (e) {
  //     print('Error loading theme preference: $e');
  //     return false;
  //   }
  // }
}
