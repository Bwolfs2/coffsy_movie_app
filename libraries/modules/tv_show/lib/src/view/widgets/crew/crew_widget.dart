import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart' hide Crew;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/crew.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'crew_store.dart';

class CrewWidget extends StatefulWidget {
  final int tvShowId;

  const CrewWidget({Key? key, required this.tvShowId}) : super(key: key);

  @override
  _CrewWidgetState createState() => _CrewWidgetState();
}

class _CrewWidgetState extends State<CrewWidget> {
  final store = Modular.get<CrewStore>();

  Future<void> reload() async {
    await store.loadTvShowTrailer(widget.tvShowId);
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
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 3,
          child: ScopedBuilder<CrewStore, Failure, List<Crew>>(
            store: store,
            onError: (context, error) {
              if (error is NoDataFound) {
                return Center(child: Text('No Crews Found'));
              }

              if (error is CrewNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
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
