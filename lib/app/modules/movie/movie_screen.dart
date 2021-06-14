import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:coffsy_movie_app/app/modules/dashboard/widgets/menu.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'pages/now_playing/bloc/movie_now_playing_bloc.dart';
import 'pages/now_playing/bloc/movie_now_playing_event.dart';
import 'pages/now_playing/bloc/movie_now_playing_state.dart';
import 'pages/popular/bloc/movie_popular_bloc.dart';
import 'pages/popular/bloc/movie_popular_event.dart';
import 'pages/popular/bloc/movie_popular_state.dart';
import 'pages/up_coming/bloc/movie_up_coming_bloc.dart';
import 'pages/up_coming/bloc/movie_up_coming_event.dart';
import 'pages/up_coming/bloc/movie_up_coming_state.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late Completer<void> _refreshCompleter;
  int _current = 0;

  _loadMovieNowPlaying(BuildContext context) {
    Modular.get<MovieNowPlayingBloc>().add(LoadMovieNowPlaying());
  }

  _loadMoviePopular(BuildContext context) {
    Modular.get<MoviePopularBloc>().add(LoadMoviePopular());
  }

  _loadMovieUpComing(BuildContext context) {
    Modular.get<MovieUpComingBloc>().add(LoadMovieUpComing());
  }

  Future<void> _refresh() {
    _loadMovieNowPlaying(context);
    _loadMoviePopular(context);
    _loadMovieUpComing(context);
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _loadMovieNowPlaying(context);
    _loadMoviePopular(context);
    _loadMovieUpComing(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Movies'),
        centerTitle: true,
        actions: <Widget>[
          // overflow menu
          PopupMenuButton<Menu>(
            icon: Icon(Icons.more_vert),
            onSelected: (Menu menu) {
              // Causes the app to rebuild with the new _selectedChoice.
              Modular.to.pushNamed(menu.route);
            },
            itemBuilder: (BuildContext context) {
              return menus.map((Menu menu) {
                return PopupMenuItem<Menu>(
                  value: menu,
                  child: Text(menu.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        showChildOpacityTransition: false,
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(), //kill bounce iOS
      child: Container(
        margin: EdgeInsets.all(Sizes.dp10(context)),
        child: Column(
          children: <Widget>[
            _buildBanner(context),
            SizedBox(
              height: Sizes.dp12(context),
            ),
            _buildUpComing(context),
            SizedBox(
              height: Sizes.dp12(context),
            ),
            _buildPopular(context),
            SizedBox(
              height: Sizes.dp12(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
      bloc: Modular.get<MovieNowPlayingBloc>(),
      builder: (context, state) {
        if (state is MovieNowPlayingHasData) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return BannerHome(
            isFromMovie: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            data: state.result,
            currentIndex: _current,
            routeNameDetail: "/detail_movies",
            routeNameAll: '/movie_module/now_playing',
          );
        } else if (state is MovieNowPlayingLoading) {
          return ShimmerBanner();
        } else if (state is MovieNowPlayingError) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return CustomErrorWidget(message: state.errorMessage);
        } else if (state is MovieNowPlayingNoData) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return CustomErrorWidget(message: state.message);
        } else if (state is MovieNowPlayingNoInternetConnection) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return NoInternetWidget(
            message: AppConstant.noInternetConnection,
            onPressed: () => _loadMovieNowPlaying(context),
          );
        } else {
          return Center(child: Text(""));
        }
      },
    );
  }

  Widget _buildUpComing(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Text(
                'Up Coming',
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
                  Modular.to.pushNamed('/movie_module/up_coming');
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: BlocBuilder<MovieUpComingBloc, MovieUpComingState>(
            bloc: Modular.get<MovieUpComingBloc>(),
            builder: (context, state) {
              if (state is MovieUpComingHasData) {
                _refreshCompleter.complete();
                _refreshCompleter = Completer();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.result.results.length > 5 ? 5 : state.result.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    Movies movies = state.result.results[index];
                    return CardHome(
                      image: movies.posterPath,
                      title: movies.title,
                      rating: movies.voteAverage,
                      onTap: () {
                        Modular.to.pushNamed(
                          "/detail_movies",
                          arguments: ScreenArguments(movies, true, false),
                        );
                      },
                    );
                  },
                );
              } else if (state is MovieUpComingLoading) {
                return ShimmerCard();
              } else if (state is MovieUpComingError) {
                _refreshCompleter.complete();
                _refreshCompleter = Completer();
                return CustomErrorWidget(message: state.errorMessage);
              } else if (state is MovieUpComingNoData) {
                _refreshCompleter.complete();
                _refreshCompleter = Completer();
                return CustomErrorWidget(message: state.message);
              } else if (state is MovieUpComingNoInternetConnection) {
                _refreshCompleter.complete();
                _refreshCompleter = Completer();
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () => _loadMovieUpComing(context),
                );
              } else {
                return Center(child: Text(""));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopular(BuildContext context) {
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
                  Modular.to.pushNamed('/movie_module/movie_popular');
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
            bloc: Modular.get<MoviePopularBloc>(),
            builder: (context, state) {
              if (state is MoviePopularHasData) {
                _refreshCompleter.complete();
                _refreshCompleter = Completer();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.result.results.length > 5 ? 5 : state.result.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    Movies movies = state.result.results[index];
                    return CardHome(
                      image: movies.posterPath,
                      title: movies.title,
                      rating: movies.voteAverage,
                      onTap: () {
                        Modular.to.pushNamed(
                          "/detail_movies",
                          arguments: ScreenArguments(movies, true, false),
                        );
                      },
                    );
                  },
                );
              } else if (state is MoviePopularLoading) {
                return ShimmerCard();
              } else if (state is MoviePopularError) {
                _refreshCompleter.complete();
                _refreshCompleter = Completer();
                return CustomErrorWidget(message: state.errorMessage);
              } else if (state is MoviePopularNoData) {
                _refreshCompleter.complete();
                _refreshCompleter = Completer();
                return CustomErrorWidget(message: state.message);
              } else if (state is MoviePopularNoInternetConnection) {
                _refreshCompleter.complete();
                _refreshCompleter = Completer();
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () => _loadMoviePopular(context),
                );
              } else {
                return Center(child: Text(""));
              }
            },
          ),
        ),
      ],
    );
  }
}
