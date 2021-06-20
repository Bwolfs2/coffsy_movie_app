import 'package:flutter_modular/flutter_modular.dart';

import 'splash_page.dart';

class SplashModule extends Module {
  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, __) => SplashPage())];
}
