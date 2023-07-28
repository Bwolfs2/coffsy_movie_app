import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/tv_show.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'airing_today_widget_store.dart';

class AiringTodayWidget extends StatefulWidget {
  const AiringTodayWidget({Key? key}) : super(key: key);

  @override
  State<AiringTodayWidget> createState() => _AiringTodayWidgetState();
}

class _AiringTodayWidgetState extends State<AiringTodayWidget> {
  final store = Modular.get<AiringTodayWidgetStore>();
  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              const Text(
                'Airing Today',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onPressed: () {
                  Modular.to.pushNamed('./airing_today', forRoot: true);
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: width,
          height: width / 1.8,
          child: ScopedBuilder<AiringTodayWidgetStore, Failure, List<TvShow>>(
            onError: (context, error) {
              if (error is NoDataFound) {
                return const Center(child: Text('No Trailers Found'));
              }

              if (error is TvAiringTodayNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: store.load,
                );
              }

              return CustomErrorWidget(message: error?.errorMessage);
            },
            onLoading: (context) => const ShimmerCard(),
            onState: (context, state) => ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.length > 5 ? 5 : state.length,
              itemBuilder: (context, index) {
                final movie = state[index];

                return CardHome(
                  image: movie.posterPath,
                  title: movie.tvName ?? 'No TV Name',
                  rating: movie.voteAverage,
                  onTap: () {
                    Modular.to.pushNamed(
                      './detail_movies',
                      arguments: ScreenArguments(
                        screenData: ScreenData(
                          movie.tvShowId,
                          movie.title,
                          movie.overview,
                          movie.releaseDate,
                          movie.genreIds,
                          movie.voteAverage,
                          movie.popularity,
                          movie.posterPath,
                          movie.backdropPath,
                          movie.tvName,
                          movie.tvRelease,
                        ),
                      ),
                      forRoot: true,
                    );
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
