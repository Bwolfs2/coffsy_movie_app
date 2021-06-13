import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:coffsy_movie_app/ui/about/about_screen.dart';
import 'package:coffsy_movie_app/ui/booking/booking_screen.dart';
import 'package:coffsy_movie_app/ui/dashboard/dashboard_screen.dart';
import 'package:coffsy_movie_app/ui/detail/detail_screen.dart';
import 'package:coffsy_movie_app/ui/home/discover_screen.dart';
import 'package:coffsy_movie_app/ui/movie/now_playing/now_playing_screen.dart';
import 'package:coffsy_movie_app/ui/movie/popular/movie_popular_screen.dart';
import 'package:coffsy_movie_app/ui/movie/up_coming/up_coming_screen.dart';
import 'package:coffsy_movie_app/ui/setting/setting_screen.dart';
import 'package:coffsy_movie_app/app/modules/splash/splash_page.dart';
import 'package:coffsy_movie_app/ui/tv_show/airing_today/airing_today_screen.dart';
import 'package:coffsy_movie_app/ui/tv_show/on_the_air/on_the_air_screen.dart';
import 'package:coffsy_movie_app/ui/tv_show/popular/tv_popular_screen.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/splash/splash_module.dart';

late SharedPreferences sharedPreferences;

class AppModule extends Module {
  // AppModule(SharedPreferences _sharedPreferences) {
  //   sharedPreferences = _sharedPreferences;
  // }

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CrewBloc(repository: i())),
    Bind.lazySingleton((i) => TrailerBloc(repository: i())),
    Bind.lazySingleton((i) => DiscoverMovieBloc(repository: i())),
    Bind.lazySingleton((i) => MovieNowPlayingBloc(repository: i())),
    Bind.lazySingleton((i) => MoviePopularBloc(repository: i())),
    Bind.lazySingleton((i) => MovieUpComingBloc(repository: i())),
    Bind.lazySingleton((i) => TvAiringTodayBloc(repository: i())),
    Bind.lazySingleton((i) => TvPopularBloc(repository: i())),
    Bind.lazySingleton((i) => TvOnTheAirBloc(repository: i())),
    Bind.lazySingleton((i) => ThemeBloc(prefHelper: i())),
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
    ChildRoute(DashBoardScreen.routeName, child: (_, __) => DashBoardScreen(title: 'Coffsy Movie App')),
    ModuleRoute(SplashModule.routeName, module: SplashModule()),
    ChildRoute(DiscoverScreen.routeName, child: (_, __) => DiscoverScreen()),
    ChildRoute(NowPlayingScreen.routeName, child: (_, __) => NowPlayingScreen()),
    ChildRoute(MoviePopularScreen.routeName, child: (_, __) => MoviePopularScreen()),
    ChildRoute(UpComingScreen.routeName, child: (_, __) => UpComingScreen()),
    ChildRoute(AiringTodayScreen.routeName, child: (_, __) => AiringTodayScreen()),
    ChildRoute(OnTheAirScreen.routeName, child: (_, __) => OnTheAirScreen()),
    ChildRoute(TvPopularScreen.routeName, child: (_, __) => TvPopularScreen()),
    ChildRoute(DetailScreen.routeName, child: (_, args) => DetailScreen(arguments: args.data)),
    ChildRoute(SettingScreen.routeName, child: (_, __) => SettingScreen()),
    ChildRoute(AboutScreen.routeName, child: (_, __) => AboutScreen()),
    ChildRoute(BookingScreen.routeName, child: (_, __) => BookingScreen()),
  ];
}
