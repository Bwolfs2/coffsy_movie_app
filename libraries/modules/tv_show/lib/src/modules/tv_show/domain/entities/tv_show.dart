class TvShow {
  final int tvShowId;
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

  TvShow(
    this.tvShowId,
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
