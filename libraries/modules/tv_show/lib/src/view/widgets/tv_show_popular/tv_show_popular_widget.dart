import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/tv_popular_show.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'tv_show_popular_store.dart';

class TvShowPopularWidget extends StatefulWidget {
  const TvShowPopularWidget({Key? key}) : super(key: key);

  @override
  _TvShowPopularWidgetState createState() => _TvShowPopularWidgetState();
}

class _TvShowPopularWidgetState extends State<TvShowPopularWidget> {
  final store = Modular.get<TvShowPopularStore>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Text(
                'Popular',
                style: TextStyle(
                  fontSize: Sizes.dp14(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: Sizes.dp16(context),
                ),
                onPressed: () {
                  Modular.to.pushNamed('./tv_popular', forRoot: true);
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: ScopedBuilder<TvShowPopularStore, Failure, List<TvPopularShow>>.transition(
            store: store,
            onError: (context, error) {
              if (error is NoDataFound) {
                return Center(child: Text('No Trailers Found'));
              }
              if (error is TvShowPopularNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () async => await store.load(),
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
              itemCount: state.length > 5 ? 5 : state.length,
              itemBuilder: (context, index) {
                final tvPopularShow = state[index];
                return CardHome(
                  image: tvPopularShow.posterPath,
                  title: tvPopularShow.tvName ?? 'No TV Name',
                  rating: tvPopularShow.voteAverage,
                  onTap: () {
                    Modular.to.pushNamed(
                      '/detail_movies',
                      arguments: ScreenArguments(
                        movies: Movies(
                          tvPopularShow.id,
                          tvPopularShow.title,
                          tvPopularShow.overview,
                          tvPopularShow.releaseDate,
                          tvPopularShow.genreIds,
                          tvPopularShow.voteAverage,
                          tvPopularShow.popularity,
                          tvPopularShow.posterPath,
                          tvPopularShow.backdropPath,
                          tvPopularShow.tvName,
                          tvPopularShow.tvRelease,
                        ),
                        isFromMovie: false,
                        isFromBanner: false,
                      ),
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
