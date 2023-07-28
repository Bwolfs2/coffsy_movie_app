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
    final _arguments = widget.arguments;
    final _screenData = _arguments.screenData;
    final _secondary = Theme.of(context).colorScheme.secondary;
    final width = MediaQuery.sizeOf(context).width;

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
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Story line',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        _screenData.overview,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: TrailerWidget(
                    key: ValueKey('${_arguments.isFromMovie}${_screenData.screenId}'),
                    movieId: _screenData.screenId,
                    isFromMovie: _arguments.isFromMovie,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: CrewWidget(
                    key: ValueKey('${_arguments.isFromMovie}${_screenData.screenId}'),
                    isFromMovie: _arguments.isFromMovie,
                    movieId: _arguments.screenData.screenId,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
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
              top: width / 9,
              right: 5,
              child: IconButton(
                iconSize: 30,
                color: _secondary,
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  PopUp.showSuccess('Add to Favorite');
                },
              ),
            ),
            Positioned(
              top: width / 9,
              left: 5,
              child: PhysicalModel(
                color: Colors.white.withOpacity(.3),
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: IconButton(
                  color: _secondary,
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
