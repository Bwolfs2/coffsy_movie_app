import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../errors/airing_today_failures.dart';
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
                  Modular.to.pushNamed('/tv_show/tv_popular');
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: ScopedBuilder<TvShowPopularStore, Failure, Result>(
            store: store,
            onError: (context, error) => error is TvShowPopularNoInternetConnection
                ? NoInternetWidget(
                    message: AppConstant.noInternetConnection,
                    onPressed: () async => await store.load(),
                  )
                : CustomErrorWidget(message: error?.errorMessage),
            onLoading: (context) => Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            onState: (context, state) => ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.results.length > 5 ? 5 : state.results.length,
              itemBuilder: (context, index) {
                final movies = state.results[index];
                return CardHome(
                  image: movies.posterPath,
                  title: movies.tvName ?? 'No TV Name',
                  rating: movies.voteAverage,
                  onTap: () {
                    Modular.to.pushNamed(
                      '/detail_movies',
                      arguments: ScreenArguments(
                        movies: movies,
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
