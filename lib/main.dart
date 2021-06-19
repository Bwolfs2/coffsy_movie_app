import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'app/shared/movie_bloc_observer.dart';

void main() async {
  // Bloc.observer = MovieBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
