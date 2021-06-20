import 'package:core/core.dart';

class ScreenArguments {
  final Movies movies;
  final bool isFromMovie;
  final bool isFromBanner;

  ScreenArguments({required this.movies, this.isFromMovie = false, this.isFromBanner = false});
}
