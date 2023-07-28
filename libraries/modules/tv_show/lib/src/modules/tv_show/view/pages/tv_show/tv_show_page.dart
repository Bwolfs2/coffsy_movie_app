import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:feedback/feedback.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/airing_today/airing_today_widget.dart';
import '../../widgets/airing_today/airing_today_widget_store.dart';
import '../../widgets/tv_show_banner/tv_show_banner_store.dart';
import '../../widgets/tv_show_banner/tv_show_banner_widget.dart';
import '../../widgets/tv_show_popular/tv_show_popular_store.dart';
import '../../widgets/tv_show_popular/tv_show_popular_widget.dart';

class TvShowPage extends StatefulWidget {
  const TvShowPage({super.key});

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  final tvShowBannerStore = Modular.get<TvShowBannerStore>();
  final airingTodayWidgetStore = Modular.get<AiringTodayWidgetStore>();
  final tvShowPopularStore = Modular.get<TvShowPopularStore>();

  Future<void> _refresh() async {
    await tvShowBannerStore.load();
    await airingTodayWidgetStore.load();
    await tvShowPopularStore.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tv Show'),
        centerTitle: true,
        actions: <Widget>[
          // overflow menu
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), //kill bounce iOS
          child: Container(
            margin: const EdgeInsets.all(10),
            child: const Column(
              children: <Widget>[
                TvShowBanner(),
                SizedBox(height: 12),
                AiringTodayWidget(),
                SizedBox(height: 12),
                TvShowPopularWidget(),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
