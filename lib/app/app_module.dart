import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:discover/discover.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'modules/dashboard/dashboard_module.dart';
import 'modules/setting/setting_module.dart';
import 'modules/splash/splash_module.dart';

import 'package:movie/movie.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [DiscoverModule(), MovieModule()];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton<DioClient>((i) => DioClient(apiBaseUrl: ApiConstant.baseUrlDebug)),
    Bind.lazySingleton<Dio>((i) => i<DioClient>().dio),
    //
    Bind.lazySingleton<ApiConfigurations>((i) => ApiConfigurations()),
    //
    Bind.lazySingleton<CoffsyAnalytics>((i) => CoffsyAnalytics()),
    //
    Bind.lazySingleton<SharedPrefHelper>((i) => SharedPrefHelper(preferences: i())),
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
