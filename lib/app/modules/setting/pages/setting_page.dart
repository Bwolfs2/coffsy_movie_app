import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:package_info/package_info.dart';

import 'setting_store.dart';

class SettingPage extends StatelessWidget {
  Future<String> _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.dp10(context)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text('Developer'),
              leading: Icon(Icons.person),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: Sizes.dp16(context),
              ),
              onTap: () => Modular.to.pushNamed('/about'),
            ),
            ListTile(
              title: Text('Theme'),
              leading: Icon(Icons.theater_comedy),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: Sizes.dp16(context),
              ),
              onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return ScopedBuilder<SettingStore, Failure, bool>(
                    store: SettingStore(),
                    onLoading: (context) => Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    onState: (context, state) => CustomDialog(
                      groupValue: state,
                      isDark: false,
                      onChanged: (value) {
                        SettingStore().changeTheme(isDark: value);
                      },
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            FutureBuilder<String>(
              future: _getVersion(),
              builder: (context, snapshot) {
                var verInfo = '';
                if (snapshot.hasData) {
                  verInfo = 'v ${snapshot.data}';
                }
                return Container(
                  margin: EdgeInsets.only(bottom: Sizes.dp30(context)),
                  child: Text(
                    verInfo,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
