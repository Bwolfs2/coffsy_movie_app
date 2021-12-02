import 'dart:io';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/crew/crew_widget.dart';
import '../../widgets/trailer/trailer_widget.dart';

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
                  idMovie: widget.arguments.screenData.id,
                  //  title: widget.arguments.movies.title ?? widget.arguments.movies.tvName,
                  title: widget.arguments.screenData.title,
                  imageBanner: widget.arguments.screenData.backdropPath.imageOriginal,
                  imagePoster: widget.arguments.screenData.posterPath.imageOriginal,
                  rating: widget.arguments.screenData.voteAverage,
                  genre: widget.arguments.screenData.genreIds.take(3).map((id) => GenreChip(id: id)).toList(),
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
                        widget.arguments.screenData.overview,
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
                    key: ValueKey('${widget.arguments.isFromMovie}${widget.arguments.screenData.id}'),
                    movieId: widget.arguments.screenData.id,
                    isFromMovie: widget.arguments.isFromMovie,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.dp20(context),
                    right: Sizes.dp20(context),
                  ),
                  child: CrewWidget(
                    key: ValueKey('${widget.arguments.isFromMovie}${widget.arguments.screenData.id}'),
                    isFromMovie: widget.arguments.isFromMovie,
                    movieId: widget.arguments.screenData.id,
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
