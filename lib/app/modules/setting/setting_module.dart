import 'package:flutter_modular/flutter_modular.dart';

import 'pages/setting_page.dart';

class SettingModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SettingPage()),
  ];
}
