import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'modules/setting/pages/setting_store.dart';

class AppWidget extends StatelessWidget {
  final store = SettingStore();
  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<SettingStore, Failure, bool>.transition(
      store: store,
      onLoading: (context) => Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      onState: (context, state) => MaterialApp(
        title: 'Coffsy Movie App',
        theme: state ? Themes.darkTheme : Themes.lightTheme,
      ).modular(),
    );
  }
}
