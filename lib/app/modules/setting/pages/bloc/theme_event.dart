import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final bool isDarkTheme;

  ThemeChanged({required this.isDarkTheme});

  @override
  List<Object> get props => [isDarkTheme];
}

class GetTheme extends ThemeEvent {}
