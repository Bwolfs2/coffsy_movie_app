import 'package:flutter_modular/flutter_modular.dart';

import 'pages/detail_screen.dart';
import 'widgets/crew/crew_store.dart';
import 'widgets/trailer/trailer_store.dart';

class DetailModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CrewStore(i())),
    Bind.lazySingleton((i) => TrailerStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DetailPage(arguments: args.data)),
  ];
}
