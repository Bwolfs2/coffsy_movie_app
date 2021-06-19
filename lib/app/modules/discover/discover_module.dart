import 'package:flutter_modular/flutter_modular.dart';

import 'pages/discover_screen.dart';
import 'pages/discover_store.dart';

class DiscoverModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DiscoverStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DiscoverScreen()),
  ];
}
