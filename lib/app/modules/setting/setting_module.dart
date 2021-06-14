import 'package:flutter_modular/flutter_modular.dart';

import 'pages/bloc/theme_bloc.dart';
import 'pages/setting_page.dart';

class SettingModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ThemeBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SettingPage()),
  ];
}
