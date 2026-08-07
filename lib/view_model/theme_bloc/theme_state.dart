import 'package:equatable/equatable.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

class ThemeLoaded extends ThemeState {
  final bool isDarkMode;

  const ThemeLoaded({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}