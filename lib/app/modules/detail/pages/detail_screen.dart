import 'dart:io';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:coffsy_movie_app/app/modules/tv_show/pages/on_the_air/bloc/tv_on_the_air_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/crew/crew_bloc.dart';
import 'bloc/crew/crew_event.dart';
import 'bloc/crew/crew_state.dart';
import 'bloc/trailer/trailer_bloc.dart';
import 'bloc/trailer/trailer_event.dart';
import 'bloc/trailer/trailer_state.dart';

class DetailPage extends StatefulWidget {
  final ScreenArguments arguments;

  const DetailPage({Key? key, required this.arguments});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void _loadTrailer(int movieId, bool isFromMovie) {
    Modular.get<TrailerBloc>().add(LoadTrailer(movieId, isFromMovie));
  }

  void _loadCrew(int movieId, bool isFromMovie) {
    Modular.get<CrewBloc>().add(LoadCrew(movieId, isFromMovie));
  }

  @override
  void initState() {
    super.initState();
    _loadTrailer(widget.arguments.movies.id, widget.arguments.isFromMovie);
    _loadCrew(widget.arguments.movies.id, widget.arguments.isFromMovie);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
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
                  padding: EdgeInsets.all(Sizes.dp20(context)),
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
                      SizedBox(height: Sizes.dp8(context)),
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
                  child: YoutubeWidget(
                    onPressed: () => _loadTrailer(widget.arguments.movies.id, widget.arguments.isFromMovie),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Sizes.dp20(context),
                    right: Sizes.dp20(context),
                  ),
                  child: CrewWidget(
                    onPressed: () => _loadCrew(widget.arguments.movies.id, widget.arguments.isFromMovie),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Sizes.dp20(context),
                    bottom: Sizes.dp20(context),
                  ),
                  child: CustomButton(
                    text: "Booking Ticket",
                    onPressed: () {
                      Modular.to.pushNamed(
                        '/booking',
                        arguments: ScreenArguments(widget.arguments.movies, true, false),
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
                color: theme.accentColor,
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  PopUp.showSuccess("Add to Favorite");
                },
              ),
            ),
            Positioned(
              top: Sizes.width(context) / 9,
              left: Sizes.dp5(context),
              child: IconButton(
                icon: Platform.isAndroid ? Icon(Icons.arrow_back) : Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YoutubeWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const YoutubeWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trailer',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.dp16(context),
          ),
        ),
        SizedBox(height: Sizes.dp8(context)),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.7,
          child: BlocBuilder<TrailerBloc, TrailerState>(
            bloc: Modular.get<TrailerBloc>(),
            builder: (context, state) {
              if (state is TrailerHasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.trailer.trailer.length,
                  itemBuilder: (BuildContext context, int index) {
                    Trailer trailer = state.trailer.trailer[index];
                    return CardTrailer(
                      title: trailer.title,
                      youtube: trailer.youtubeId,
                      length: state.trailer.trailer.length,
                      onExitFullScreen: () {
                        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                      },
                    );
                  },
                );
              } else if (state is TrailerLoading) {
                return ShimmerTrailer();
              } else if (state is TrailerError) {
                return CustomErrorWidget(message: state.errorMessage);
              } else if (state is TrailerNoData) {
                return CustomErrorWidget(message: state.message);
              } else if (state is TrailerNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () => onPressed(),
                );
              } else {
                return Center(child: Text(""));
              }
            },
          ),
        ),
      ],
    );
  }
}

class CrewWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const CrewWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Crew',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.dp16(context),
          ),
        ),
        SizedBox(height: Sizes.dp8(context)),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 3,
          child: BlocBuilder<CrewBloc, CrewState>(
            bloc: Modular.get<CrewBloc>(),
            builder: (context, state) {
              if (state is CrewHasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.crew.crew.length,
                  itemBuilder: (BuildContext context, int index) {
                    Crew crew = state.crew.crew[index];
                    return CardCrew(
                      image: crew.profile!,
                      name: crew.characterName,
                    );
                  },
                );
              } else if (state is CrewLoading) {
                return ShimmerCrew();
              } else if (state is CrewError) {
                return CustomErrorWidget(message: state.errorMessage);
              } else if (state is CrewNoData) {
                return CustomErrorWidget(message: state.message);
              } else if (state is CrewNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () => onPressed(),
                );
              } else {
                return Center(child: Text(""));
              }
            },
          ),
        ),
      ],
    );
  }
}
