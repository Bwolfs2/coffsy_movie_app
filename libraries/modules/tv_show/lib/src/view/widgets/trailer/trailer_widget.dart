import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart' hide Trailer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/trailer.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'trailer_store.dart';

class TrailerWidget extends StatefulWidget {
  final int movieId;

  const TrailerWidget({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  _TrailerWidgetState createState() => _TrailerWidgetState();
}

class _TrailerWidgetState extends State<TrailerWidget> {
  final store = Modular.get<TrailerStore>();

  void reload() {
    store.loadTvShowTrailer(widget.movieId);
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
          child: ScopedBuilder<TrailerStore, Failure, List<Trailer>>(
            store: store,
            onError: (context, error) {
              if (error is NoDataFound) {
                return Center(child: Text('No Trailers Found'));
              }
              if (error is TrailerNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noTrailer,
                  onPressed: () async => reload(),
                );
              }
              return CustomErrorWidget(message: error?.errorMessage);
            },
            onLoading: (context) => Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            onState: (context, state) => ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
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
