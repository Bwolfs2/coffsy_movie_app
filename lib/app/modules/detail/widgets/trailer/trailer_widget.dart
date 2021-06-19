import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:coffsy_movie_app/app/modules/movie/widgets/up_coming/up_coming_widget_store.dart';

import 'trailer_store.dart';

class TrailerWidget extends StatefulWidget {
  final int movieId;
  final bool isFromMovie;
  const TrailerWidget({
    Key? key,
    required this.movieId,
    required this.isFromMovie,
  }) : super(key: key);

  @override
  _TrailerWidgetState createState() => _TrailerWidgetState();
}

class _TrailerWidgetState extends State<TrailerWidget> {
  var store = Modular.get<TrailerStore>();

  void reload() {
    if (widget.isFromMovie) {
      store.loadMovieTrailer(widget.movieId);
    } else {
      store.loadTvShowTrailer(widget.movieId);
    }
  }

  @override
  void initState() {
    super.initState();
    reload();
  }

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
          child: ScopedBuilder<TrailerStore, Failure, ResultTrailer>(
            store: store,
            onError: (context, error) => error is MovieUpComingNoInternetConnection
                ? NoInternetWidget(
                    message: AppConstant.noTrailer,
                    onPressed: () async => reload(),
                  )
                : CustomErrorWidget(message: error?.errorMessage),
            onLoading: (context) => Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            onState: (context, state) => ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.trailer.length,
              itemBuilder: (BuildContext context, int index) {
                final trailer = state.trailer[index];
                return CardTrailer(
                  title: trailer.title,
                  youtube: trailer.youtubeId,
                  length: state.trailer.length,
                  onExitFullScreen: () {
                    // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
