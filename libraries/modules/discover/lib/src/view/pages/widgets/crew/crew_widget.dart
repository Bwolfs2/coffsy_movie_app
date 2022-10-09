import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../domain/entities/crew.dart';
import '../../../../domain/errors/discover_failures.dart';
import 'crew_store.dart';

class CrewWidget extends StatefulWidget {
  final int movieId;
  final bool isFromMovie;
  const CrewWidget({Key? key, required this.movieId, required this.isFromMovie}) : super(key: key);

  @override
  State<CrewWidget> createState() => _CrewWidgetState();
}

class _CrewWidgetState extends State<CrewWidget> {
  final store = Modular.get<CrewStore>();

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
          'Crew',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.dp16(context),
          ),
        ),
        SizedBox(height: Sizes.dp8(context)),
        SizedBox(
          width: Sizes.width(context),
          height: Sizes.width(context) / 3,
          child: ScopedBuilder<CrewStore, Failure, List<Crew>>.transition(
            onError: (context, error) => error is CrewNoInternetConnection
                ? NoInternetWidget(
                    message: AppConstant.noInternetConnection,
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
                final crew = state[index];
                return CardCrew(
                  image: crew.profile!,
                  name: crew.characterName,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
