class ScreenArguments {
  final ScreenData screenData;
  final bool isFromMovie;
  final bool isFromBanner;

  ScreenArguments({required this.screenData, this.isFromMovie = false, this.isFromBanner = false});
}

class ScreenData {
  final int id;

  final String title;

  final String overview;

  final String releaseDate;

  final List<int> genreIds;

  final double voteAverage;

  final double popularity;

  final String posterPath;

  final String backdropPath;

  final String? tvName;

  final String? tvRelease;

  ScreenData(
    this.id,
    this.title,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.voteAverage,
    this.popularity,
    this.posterPath,
    this.backdropPath,
    this.tvName,
    this.tvRelease,
  );
}
