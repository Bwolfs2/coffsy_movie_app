import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../dashboard/widgets/menu.dart';
import 'widgets/movie_banner/movie_banner_store.dart';
import 'widgets/movie_banner/movie_banners.dart';
import 'widgets/popular/popular.dart';
import 'widgets/popular/popular_store.dart';
import 'widgets/up_coming/up_coming_widget.dart';
import 'widgets/up_coming/up_coming_widget_store.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  Future<void> _refresh() async {
    Future.wait([
      Modular.get<MovieBannerStore>().load(),
      Modular.get<UpComingWidgetStore>().load(),
      Modular.get<PopularStore>().load(),
    ]).then((value) => print('Reloaded'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Movies'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<Menu>(
            icon: Icon(Icons.more_vert),
            onSelected: (menu) {
              Modular.to.pushNamed(menu.route);
            },
            itemBuilder: (context) {
              return menus.map((menu) {
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
        springAnimationDurationInMilliseconds: 500,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.all(Sizes.dp10(context)),
            child: Column(
              children: <Widget>[
                MovieBanners(),
                SizedBox(
                  height: Sizes.dp12(context),
                ),
                UpComingWidget(),
                SizedBox(
                  height: Sizes.dp12(context),
                ),
                Pupular(),
                SizedBox(
                  height: Sizes.dp12(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
