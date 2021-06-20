import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../dashboard/widgets/menu.dart';
import 'widgets/airing_today/airing_today_widget.dart';
import 'widgets/airing_today/airing_today_widget_store.dart';
import 'widgets/tv_show_banner/tv_show_banner_store.dart';
import 'widgets/tv_show_banner/tv_show_banner_widget.dart';
import 'widgets/tv_show_popular/tv_show_popular_store.dart';
import 'widgets/tv_show_popular/tv_show_popular_widget.dart';

class TvShowScreen extends StatefulWidget {
  @override
  _TvShowScreenState createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  Future<void> _refresh() async {
    Modular.get<TvShowBannerStore>().load();
    Modular.get<AiringTodayWidgetStore>().load();
    Modular.get<TvShowPopularStore>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tv Show'),
        centerTitle: true,
        actions: <Widget>[
          // overflow menu
          PopupMenuButton<Menu>(
            icon: Icon(Icons.more_vert),
            onSelected: (menu) {
              // Causes the app to rebuild with the new _selectedChoice.
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
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(), //kill bounce iOS
          child: Container(
            margin: EdgeInsets.all(Sizes.dp10(context)),
            child: Column(
              children: <Widget>[
                TvShowBanner(),
                SizedBox(height: Sizes.dp12(context)),
                AiringTodayWidget(),
                SizedBox(height: Sizes.dp12(context)),
                TvShowPopularWidget(),
                SizedBox(height: Sizes.dp12(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
