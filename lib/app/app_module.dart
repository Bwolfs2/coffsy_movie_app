import 'package:coffsy_movie_app/app/modules/discover/discover_module.dart';
import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/about/about_module.dart';
import 'modules/booking/booking_module.dart';
import 'modules/dashboard/dashboard_module.dart';
import 'modules/detail/detail_module.dart';
import 'modules/movie/pages/now_playing/bloc/movie_now_playing_bloc.dart';
import 'modules/movie/pages/popular/bloc/movie_popular_bloc.dart';
import 'modules/movie/pages/up_coming/bloc/movie_up_coming_bloc.dart';
import 'modules/setting/setting_module.dart';
import 'modules/splash/splash_module.dart';

late SharedPreferences sharedPreferences;

class AppModule extends Module {
  // AppModule(SharedPreferences _sharedPreferences) {
  //   sharedPreferences = _sharedPreferences;
  // }

  @override
  final List<Bind> binds = [
    //
    Bind.lazySingleton((i) => MovieRepository(apiRepository: i(), localRepository: i())),
    Bind.lazySingleton((i) => LocalRepository(prefHelper: i())),
    Bind.lazySingleton((i) => ApiRepository(apiService: i())),
    Bind.lazySingleton((i) => SharedPrefHelper()),
    Bind.lazySingleton((i) => ApiService(dio: i<DioClient>().dio)),
    Bind.lazySingleton((i) => DioClient(apiBaseUrl: ApiConstant.baseUrlDebug)),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute("/", module: SplashModule()),
    ModuleRoute("/dashboard", module: DashboardModule()),
    ModuleRoute("/detail_movies", module: DetailModule()),
    ModuleRoute('/discover_movie', module: DiscoverModule()),
    ModuleRoute('/about', module: AboutModule()),
    ModuleRoute('/theme', module: SettingModule()),
    ModuleRoute('/booking', module: BookingModule()),
  ];
}
