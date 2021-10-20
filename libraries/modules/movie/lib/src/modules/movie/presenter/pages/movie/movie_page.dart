import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:feedback/feedback.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/movie_banner/movie_banner.dart';
import '../../widgets/movie_banner/movie_banner_store.dart';
import '../../widgets/popular/popular_store.dart';
import '../../widgets/popular/popular_widget.dart';
import '../../widgets/up_coming/up_coming_widget.dart';
import '../../widgets/up_coming/up_coming_widget_store.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  Future<void> _refresh() async {
    Future.wait([
      Modular.get<MovieBannerStore>().load(),
      Modular.get<UpComingWidgetStore>().load(),
      Modular.get<PopularStore>().load(),
    ]).then(
      (value) => debugPrint('Reloaded'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Movies'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<Menu>(
            icon: const Icon(Icons.more_vert),
            onSelected: (menu) {
              if (menu.isFeedBack) {
                BetterFeedback.of(context).show((feedback) {
                  FirebaseStorage.instance.ref().child('feedbacks+${const Uuid().v4()}').putData(
                        feedback.screenshot,
                        SettableMetadata(customMetadata: {'message': feedback.text}),
                      );
                });
              } else {
                Modular.to.pushNamed(menu.route);
              }
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
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.all(
            Sizes.dp10(context),
          ),
          children: <Widget>[
            const MovieBanner(),
            SizedBox(
              height: Sizes.dp12(context),
            ),
            const UpComingWidget(),
            SizedBox(
              height: Sizes.dp12(context),
            ),
            const PopularWidget(),
            SizedBox(
              height: Sizes.dp12(context),
            ),
          ],
        ),
      ),
    );
  }
}
