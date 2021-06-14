import 'package:flutter_modular/flutter_modular.dart';

import 'about_screen.dart';

class AboutModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AboutScreen()),
  ];
}
