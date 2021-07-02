import 'package:flutter_modular/flutter_modular.dart';

import 'data/datasources/tv_show_datasource_impl.dart';
import 'domain/usecases/get_tv_airing_today.dart';
import 'domain/usecases/get_tv_on_the_air.dart';
import 'domain/usecases/get_tv_popular_show.dart';
import 'infra/repositories/tv_show_repository_impl.dart';
import 'view/pages/airing_today/airing_today_page.dart';
import 'view/pages/airing_today/airing_today_store.dart';
import 'view/pages/detail/detail_page.dart';
import 'view/pages/on_the_air/on_the_air_page.dart';
import 'view/pages/on_the_air/on_the_air_store.dart';
import 'view/pages/popular/tv_popular_page.dart';
import 'view/pages/popular/tv_popular_store.dart';
import 'view/pages/tv_show/tv_show_page.dart';
import 'view/widgets/airing_today/airing_today_widget_store.dart';
import 'view/widgets/crew/crew_store.dart';
import 'view/widgets/trailer/trailer_store.dart';
import 'view/widgets/tv_show_banner/tv_show_banner_store.dart';
import 'view/widgets/tv_show_popular/tv_show_popular_store.dart';

class TvShowModule extends Module {
  @override
  final List<Bind> binds = [
    //Stores
    Bind.lazySingleton((i) => AiringTodayStore(i())),
    Bind.lazySingleton((i) => TvPopularStore(i())),
    Bind.lazySingleton((i) => TvShowPopularStore(i())),
    Bind.lazySingleton((i) => TvShowBannerStore(i())),
    Bind.lazySingleton((i) => OnTheAirStore(i())),
    Bind.lazySingleton((i) => AiringTodayWidgetStore(i())),
    Bind.lazySingleton((i) => CrewStore(i())),
    Bind.lazySingleton((i) => TrailerStore(i())),

    //Datasource
    Bind.lazySingleton((i) => TvShowDatasourceImpl(i(), i())),
    //Repositories
    Bind.lazySingleton((i) => TvShowRepositoryImpl(i())),
    //UseCases
    Bind.lazySingleton((i) => GetTvAiringToday(i())),
    Bind.lazySingleton((i) => GetTvPopularShow(i())),
    Bind.lazySingleton((i) => GetOnTheAir(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => TvShowPage()),
    ChildRoute('/airing_today', child: (context, args) => AiringTodayPage()),
    ChildRoute('/on_the_air', child: (context, args) => OnTheAirPage()),
    ChildRoute('/tv_popular', child: (context, args) => TvPopularPage()),
    ChildRoute('/detail', child: (context, args) => DetailPage(arguments: args.data)),
  ];
}
