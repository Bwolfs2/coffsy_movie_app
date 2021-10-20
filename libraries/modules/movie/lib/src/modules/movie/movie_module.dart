import 'package:booking/booking.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/movie.dart';

import 'domain/use_cases/get_movie_crew_by_id.dart';
import 'domain/use_cases/get_movie_now_playing.dart';
import 'domain/use_cases/get_movie_popular.dart';
import 'domain/use_cases/get_movie_trailer_by_id.dart';
import 'domain/use_cases/get_movie_up_coming.dart';
import 'domain/use_cases/get_tv_show_crew_by_id.dart';
import 'domain/use_cases/get_tv_show_trailer_by_id.dart';

import 'presenter/pages/detail/detail_page.dart';
import 'presenter/pages/movie/movie_page.dart';
import 'presenter/pages/now_playing/now_playing_page.dart';
import 'presenter/pages/now_playing/now_playing_store.dart';
import 'presenter/pages/popular/movie_popular_page.dart';
import 'presenter/pages/popular/movie_popular_store.dart';
import 'presenter/pages/up_coming/up_coming_page.dart';
import 'presenter/pages/up_coming/up_coming_store.dart';
import 'presenter/widgets/crew/crew_store.dart';
import 'presenter/widgets/popular/popular_store.dart';
import 'presenter/widgets/trailer/trailer_store.dart';
import 'presenter/widgets/up_coming/up_coming_widget_store.dart';

class MovieModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MoviePlayingStore(i()), export: true),
    Bind.lazySingleton((i) => MoviePopularStore(i()), export: true),
    Bind.lazySingleton((i) => UpComingWidgetStore(i()), export: true),
    Bind.lazySingleton((i) => MoviePlayingStore(i()), export: true),
    Bind.lazySingleton((i) => UpComingStore(i()), export: true),
    Bind.lazySingleton((i) => PopularStore(i()), export: true),

    Bind.lazySingleton((i) => CrewStore(i(), i()), export: true),
    Bind.lazySingleton((i) => TrailerStore(i(), i()), export: true),

    //useCases

    Bind.lazySingleton((i) => GetMoviePopular(i()), export: true),
    Bind.lazySingleton((i) => GetMovieUpComming(i()), export: true),
    Bind.lazySingleton((i) => GetMovieTrailerById(i()), export: true),
    Bind.lazySingleton((i) => GetTvShowTrailer(i()), export: true),
    Bind.lazySingleton((i) => GetTvShowCrewById(i()), export: true),
    Bind.lazySingleton((i) => GetMovieCrewById(i()), export: true),

    ///
    Bind.lazySingleton<MovieBannerStore>((i) => MovieBannerStore(i()), export: true),
    Bind.lazySingleton<IGetMovieNowPlaying>((i) => GetMovieNowPlaying(i()), export: true),

    //Datasources
    Bind.lazySingleton<MovieDataSource>((i) => MovieDataSourceImpl(i(), i()), export: true),
    //repositories
    Bind.lazySingleton<MoviesRepository>((i) => MoviesRepositoryImpl(i()), export: true),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MoviePage()),
    ChildRoute('/now_playing', child: (_, __) => NowPlayingPage()),
    ChildRoute('/movie_popular', child: (_, __) => MoviePopularPage()),
    ChildRoute('/up_coming', child: (_, __) => UpComingPage()),
    ChildRoute('/detail_movies', child: (_, args) => DetailPage(arguments: args.data)),
    ModuleRoute('/booking', module: BookingModule()),
  ];
}
