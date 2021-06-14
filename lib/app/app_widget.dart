import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:coffsy_movie_app/app/modules/tv_show/pages/popular/tv_popular_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/setting/pages/bloc/theme_bloc.dart';
import 'modules/setting/pages/bloc/theme_event.dart';
import 'modules/setting/pages/bloc/theme_state.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
        bloc: ThemeBloc()..add(GetTheme()),
        builder: (context, state) {
          return MaterialApp(
            title: 'Coffsy Movie App',
            theme: state.isDarkTheme ? Themes.darkTheme : Themes.lightTheme,
          ).modular();
        });
  }
}
