import 'dart:io';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../widgets/crew/crew_widget.dart';
import '../widgets/trailer/trailer_widget.dart';

class DetailPage extends StatefulWidget {
  final ScreenArguments arguments;

  const DetailPage({Key? key, required this.arguments});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                CardMoviesHeader(
                  isFromBanner: widget.arguments.isFromBanner,
                  idMovie: widget.arguments.movies.id,
                  //  title: widget.arguments.movies.title ?? widget.arguments.movies.tvName,
                  title: widget.arguments.movies.title,
                  imageBanner: widget.arguments.movies.backdropPath.imageOriginal,
                  imagePoster: widget.arguments.movies.posterPath.imageOriginal,
                  rating: widget.arguments.movies.voteAverage,
                  genre: widget.arguments.movies.genreIds.take(3).map(buildGenreChip).toList(),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    Sizes.dp20(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Story line',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.dp16(context),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.dp8(context),
                      ),
                      Text(
                        widget.arguments.movies.overview,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.dp20(context),
                    right: Sizes.dp20(context),
                  ),
                  child: TrailerWidget(
                    key: ValueKey('${widget.arguments.isFromMovie}${widget.arguments.movies.id}'),
                    movieId: widget.arguments.movies.id,
                    isFromMovie: widget.arguments.isFromMovie,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.dp20(context),
                    right: Sizes.dp20(context),
                  ),
                  child: CrewWidget(
                    key: ValueKey('${widget.arguments.isFromMovie}${widget.arguments.movies.id}'),
                    isFromMovie: widget.arguments.isFromMovie,
                    movieId: widget.arguments.movies.id,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Sizes.dp20(context),
                    bottom: Sizes.dp20(context),
                  ),
                  child: CustomButton(
                    text: 'Booking Ticket',
                    onPressed: () {
                      Modular.to.pushNamed(
                        './booking',
                        arguments: ScreenArguments(
                          movies: widget.arguments.movies,
                          isFromMovie: true,
                          isFromBanner: false,
                        ),
                        forRoot: true,
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              top: Sizes.width(context) / 9,
              right: Sizes.dp5(context),
              child: IconButton(
                iconSize: Sizes.dp30(context),
                color: theme.colorScheme.secondary,
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  PopUp.showSuccess('Add to Favorite');
                },
              ),
            ),
            Positioned(
              top: Sizes.width(context) / 9,
              left: Sizes.dp5(context),
              child: IconButton(
                icon: Platform.isAndroid ? const Icon(Icons.arrow_back) : const Icon(Icons.arrow_back_ios),
                onPressed: () => Modular.to.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
