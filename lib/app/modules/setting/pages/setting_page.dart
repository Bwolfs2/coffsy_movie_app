import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:package_info/package_info.dart';

import 'setting_store.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _remoteConfig = FirebaseRemoteConfig.instance;

  Future<String> _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  @override
  void initState() {
    super.initState();

    _remoteConfig.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.dp10(context)),
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Developer'),
              leading: const Icon(Icons.person),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: Sizes.dp16(context),
              ),
              onTap: () => Modular.to.pushNamed('/about'),
            ),
            if (_remoteConfig.getBool('can_change_theme'))
              ListTile(
                title: const Text('Theme'),
                leading: const Icon(Icons.theater_comedy),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: Sizes.dp16(context),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return ScopedBuilder<SettingStore, Failure, bool>.transition(
                      store: SettingStore(),
                      onLoading: (context) => const Center(
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
            const Spacer(),
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
