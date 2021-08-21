import 'package:booking/booking.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/use_cases/get_discover_movie.dart';
import 'domain/use_cases/get_movie_crew_by_id.dart';
import 'domain/use_cases/get_movie_trailer_by_id.dart';
import 'domain/use_cases/get_tv_show_crew_by_id.dart';
import 'domain/use_cases/get_tv_show_trailer_by_id.dart';
import 'external/datasource/discovery_movie_datasource_impl.dart';
import 'external/datasource/discovery_movie_local_datasource_impl.dart';
import 'infra/repositories/discovery_movie_repository_impl.dart';
import 'view/pages/detail/detail_page.dart';
import 'view/pages/discover_page/discover_page.dart';
import 'view/pages/discover_page/discover_store.dart';
import 'view/pages/widgets/crew/crew_store.dart';
import 'view/pages/widgets/trailer/trailer_store.dart';

class DiscoverModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DiscoverStore(i())),
    Bind.lazySingleton((i) => TrailerStore(i(), i())),
    Bind.lazySingleton((i) => CrewStore(i(), i())),
    Bind.lazySingleton((i) => DiscoveryMovieDatasourceImpl(i(), i())),
    Bind.lazySingleton((i) => DiscoveryMovieLocalDatasourceImpl(i())),
    Bind.lazySingleton((i) => DiscoveryMovieRepositoryImpl(i(), i())),
    Bind.lazySingleton((i) => GetDiscoverMovie(i())),
    Bind.lazySingleton((i) => GetMovieCrewById(i())),
    Bind.lazySingleton((i) => GetMovieTrailerById(i())),
    Bind.lazySingleton((i) => GetTvShowCrewById(i())),
    Bind.lazySingleton((i) => GetTvShowTrailerById(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DiscoverPage()),
    ChildRoute('/detail_movies', child: (_, args) => DetailPage(arguments: args.data)),
    ModuleRoute('/booking', module: BookingModule()),
  ];
}
