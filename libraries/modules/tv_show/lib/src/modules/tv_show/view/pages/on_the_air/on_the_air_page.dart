import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../domain/entities/on_the_air.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'on_the_air_store.dart';

class OnTheAirPage extends StatefulWidget {
  const OnTheAirPage({super.key});

  @override
  State<OnTheAirPage> createState() => _OnTheAirPageState();
}

class _OnTheAirPageState extends State<OnTheAirPage> {
  final store = Modular.get<OnTheAirStore>();
  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<OnTheAirStore, Failure, List<OnTheAir>>.transition(
          onError: (context, error) {
            if (error is NoDataFound) {
              return const Center(child: Text('No On The Air Found'));
            }

            if (error is TvOnTheAirNoInternetConnection) {
              return Center(
                child: NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: store.load,
                ),
              );
            }

            return CustomErrorWidget(message: error?.errorMessage);
          },
          onLoading: (context) => const ShimmerList(),
          onState: (context, state) => ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final onTheAir = state[index];

              return CardMovies(
                image: onTheAir.posterPath,
                title: onTheAir.tvName ?? 'No TV Name',
                vote: onTheAir.voteAverage.toString(),
                releaseDate: onTheAir.tvRelease ?? 'No TV Release',
                overview: onTheAir.overview,
                genre: onTheAir.genreIds.take(3).map((id) => GenreChip(id: id)).toList(),
                onTap: () {
                  Modular.to.pushNamed(
                    './detail_movies',
                    arguments: ScreenArguments(
                      screenData: ScreenData(
                        onTheAir.id,
                        onTheAir.title,
                        onTheAir.overview,
                        onTheAir.releaseDate,
                        onTheAir.genreIds,
                        onTheAir.voteAverage,
                        onTheAir.popularity,
                        onTheAir.posterPath,
                        onTheAir.backdropPath,
                        onTheAir.tvName,
                        onTheAir.tvRelease,
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
    );
  }
}
