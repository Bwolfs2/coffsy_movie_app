import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static ThemeBloc? _instance;

  static ThemeBloc get getInstance => _instance ??= ThemeBloc._(prefHelper: SharedPrefHelper());

  final SharedPrefHelper prefHelper;

  ThemeBloc._({required this.prefHelper}) : super(ThemeState(isDarkTheme: false));

  factory ThemeBloc() => getInstance;

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      await prefHelper.saveValueDarkTheme(event.isDarkTheme);
      yield ThemeState(isDarkTheme: event.isDarkTheme);
    } else if (event is GetTheme) {
      var isDarkTheme = await prefHelper.getValueDarkTheme();
      yield ThemeState(isDarkTheme: isDarkTheme);
    }
  }
}
