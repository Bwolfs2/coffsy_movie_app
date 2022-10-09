import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/trailer.dart';
import '../../../domain/errors/movie_failures.dart';
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
  State<TrailerWidget> createState() => _TrailerWidgetState();
}

class _TrailerWidgetState extends State<TrailerWidget> {
  final store = Modular.get<TrailerStore>();

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
        SizedBox(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.7,
          child: ScopedBuilder<TrailerStore, Failure, List<Trailer>>.transition(
            store: store,
            onError: (context, error) => error is TrailerNoInternetConnection
                ? NoInternetWidget(
                    message: AppConstant.noTrailer,
                    onPressed: () async => reload(),
                  )
                : CustomErrorWidget(message: error?.errorMessage),
            onLoading: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            onState: (context, state) => ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.length,
              itemBuilder: (context, index) {
                final trailer = state[index];
                return CardTrailer(
                  title: trailer.title,
                  youtube: trailer.youtubeId,
                  length: state.length,
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
