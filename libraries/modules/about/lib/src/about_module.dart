import 'package:flutter_modular/flutter_modular.dart';

import 'about_page.dart';

class AboutModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AboutPage()),
  ];
}
