import '../../domain/entities/crew.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/trailer.dart';
import 'discovery_movie_datasource.dart';

abstract class DiscoveryMovieLocalDatasource extends DiscoveryMovieDatasource {
  void setDiscoverMovie(List<Movie> data);
  void setTvShowTrailerById(List<Trailer> data);
  void setMovieTrailerById(List<Trailer> data);
  void setMovieCrew(List<Crew> data);
  void setTvShowCrewById(List<Crew> data);
}
