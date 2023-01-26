import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../domain/errors/tv_show_failures.dart';
import 'airing_today_states.dart';
import 'airing_today_store.dart';

class AiringTodayPage extends StatefulWidget {
  const AiringTodayPage({super.key});

  @override
  State<AiringTodayPage> createState() => _AiringTodayPageState();
}

class _AiringTodayPageState extends State<AiringTodayPage> {
  final store = Modular.get<AiringTodayStore>();
  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: () async => store.load(),
        showChildOpacityTransition: false,
        child: ValueListenableBuilder<AiringTodayState>(
          valueListenable: Modular.get<AiringTodayStore>(),
          builder: (context, state, child) {
            if (state is AiringTodayFailure) {
              if (state.failure is NoDataFound) {
                return const Center(child: Text('No Airing Today Found'));
              }
              if (state.failure is TvAiringTodayNoInternetConnection) {
                return Center(
                  child: NoInternetWidget(
                    message: AppConstant.noInternetConnection,
                    onPressed: store.load,
                  ),
                );
              }
              return CustomErrorWidget(message: state.failure.errorMessage);
            }

            if (state is AiringTodayValued) {
              return ListView.builder(
                itemCount: state.value.length,
                itemBuilder: (context, index) {
                  final movie = state.value[index];
                  return CardMovies(
                    image: movie.posterPath,
                    title: movie.tvName ?? 'No TV Name',
                    vote: movie.voteAverage.toString(),
                    releaseDate: movie.tvRelease ?? 'No TV Release',
                    overview: movie.overview,
                    genre: movie.genreIds.take(3).map((id) => GenreChip(id: id)).toList(),
                    onTap: () {
                      Modular.to.pushNamed(
                        './detail_movies',
                        arguments: ScreenArguments(
                          screenData: ScreenData(
                            movie.id,
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
              );
            }

            return const ShimmerList();
          },
        ),
      ),
    );
  }
}
