import 'package:flutter_modular/flutter_modular.dart';

import 'ui/pages/about_page.dart';

class AboutModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const AboutPage()),
  ];
}
