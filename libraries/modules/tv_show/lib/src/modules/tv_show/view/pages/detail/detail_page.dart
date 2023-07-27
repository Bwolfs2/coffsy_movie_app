import 'dart:io';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/crew/crew_widget.dart';
import '../../widgets/trailer/trailer_widget.dart';

class DetailPage extends StatefulWidget {
  final ScreenArguments arguments;

  const DetailPage({super.key, required this.arguments});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _arguments = widget.arguments;
    final _screenData = _arguments.screenData;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: [
                CardMoviesHeader(
                  isFromBanner: widget.arguments.isFromBanner,
                  idMovie: _screenData.screenId,
                  //  title: widget.arguments.movies.title ?? widget.arguments.movies.tvName,
                  title: _screenData.title,
                  imageBanner: _screenData.backdropPath.imageOriginal,
                  imagePoster: _screenData.posterPath.imageOriginal,
                  rating: _screenData.voteAverage,
                  genre: _screenData.genreIds.take(3).map((id) => GenreChip(genreId: id)).toList(),
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
                        _screenData.overview,
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
                    key: ValueKey('${_arguments.isFromMovie}${_screenData.screenId}'),
                    movieId: _screenData.screenId,
                    isFromMovie: _arguments.isFromMovie,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.dp20(context),
                    right: Sizes.dp20(context),
                  ),
                  child: CrewWidget(
                    key: ValueKey('${_arguments.isFromMovie}${_screenData.screenId}'),
                    isFromMovie: _arguments.isFromMovie,
                    movieId: _screenData.screenId,
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
                          screenData: widget.arguments.screenData,
                          isFromMovie: true,
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
              child: PhysicalModel(
                color: Colors.white.withOpacity(.3),
                borderRadius: BorderRadius.circular(100),
                child: IconButton(
                  color: Theme.of(context).colorScheme.secondary,
                  icon: Platform.isAndroid ? const Icon(Icons.arrow_back) : const Icon(Icons.arrow_back_ios),
                  onPressed: () => Modular.to.pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
