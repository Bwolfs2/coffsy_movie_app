import 'package:pulsar/pulsar.dart';

import 'splash_page.dart';

class SplashModule extends Module {
  @override
  final List<PulsarRoute> routes = [ChildRoute('/', child: (_, __) => const SplashPage())];
}
