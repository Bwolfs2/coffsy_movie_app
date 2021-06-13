import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
// TODO: This is not recommendation
import 'package:core/core.dart' as di;

import 'launcher/movie_app.dart';

void main() async {
  Bloc.observer = MovieBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(ApiConstant.baseUrlDebug);
  runApp(MovieApp());
}
