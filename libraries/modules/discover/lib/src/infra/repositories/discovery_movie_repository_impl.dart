import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import '../../domain/repositories/discovery_movie_repository.dart';
import '../datasources/discovery_movie_datasource.dart';

class DiscoveryMovieRepositoryImpl implements IDiscoveryMovieRepository {
  final DiscoveryMovieDatasource _discoveryMovieDatasource;

  DiscoveryMovieRepositoryImpl(this._discoveryMovieDatasource);

  @override
  Future<List<Movie>> getDiscoverMovie() => _discoveryMovieDatasource.getDiscoverMovie();

  @override
  Future<List<Trailer>> getMovieTrailerById(int id) => _discoveryMovieDatasource.getMovieTrailerById(id);

  @override
  Future<List<Trailer>> getTvShowTrailerById(int movieId) => _discoveryMovieDatasource.getTvShowTrailerById(movieId);

  @override
  Future<List<Crew>> getMovieCrew(int id) => _discoveryMovieDatasource.getMovieCrew(id);

  @override
  Future<List<Crew>> getTvShowCrewById(int movieId) => _discoveryMovieDatasource.getTvShowCrewById(movieId);
}
