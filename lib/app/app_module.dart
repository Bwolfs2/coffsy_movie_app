import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:discover/discover.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_show/tv_show.dart';

import 'modules/dashboard/dashboard_module.dart';
import 'modules/setting/setting_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [DiscoverModule(), MovieModule(), TvShowModule()];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton<CoffsyFirebaseAnalytics>((i) => CoffsyFirebaseAnalytics()),
    //
    Bind.lazySingleton<SharedPrefHelper>((i) => SharedPrefHelper(preferences: i())),
    //
    Bind<IHttpClient>(
      (i) => DioHttpClient(
        baseApiUrl: ApiConfigurations().baseUrlProd,
        interceptors: [AuthInterceptor(ApiConfigurations())],
      ),
    ),
    //
    AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/dashboard', module: DashboardModule()),
    ModuleRoute('/discover_movie', module: DiscoverModule()),
    ModuleRoute('/about', module: AboutModule()),
    ModuleRoute('/theme', module: SettingModule()),
  ];
}
