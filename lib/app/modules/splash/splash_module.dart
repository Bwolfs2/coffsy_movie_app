import 'package:coffsy_movie_app/app/modules/splash/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  static const routeName = "/splash";

  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, __) => SplashPage())];
}
