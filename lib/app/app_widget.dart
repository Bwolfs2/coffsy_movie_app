import 'package:coffsy_movie_app/app/modules/splash/splash_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffsy Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashModule.routeName,
    ).modular();
  }
}
