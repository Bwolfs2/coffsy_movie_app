import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../app_module.dart';

/// SplashPage
/// <img src="https://raw.githubusercontent.com/rrifafauzikomara/MovieApp/master/screenshot/ios1.png" width="300">
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  Future<String> _getVersion() async {
    final info = await PackageInfo.fromPlatform();

    return info.version;
  }

  Future<void> _startSplashPage() async {
    await Future.wait([
      CrashalytcsService.initializeFlutterFire(),
      _remoteConfig.ensureInitialized(),
      _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          minimumFetchInterval: const Duration(seconds: 60),
          fetchTimeout: const Duration(
            seconds: 60,
          ),
        ),
      ),
      Modular.isModuleReady<AppModule>(),
      Future.delayed(const Duration(seconds: 2)),
    ]).then((value) async {
      try {
        await _remoteConfig.fetchAndActivate();
      } on FormatException {
        await _remoteConfig.setDefaults({'can_change_theme': true});
      }
    }).then(
      (value) => Modular.to.navigate('/dashboard/movie_module/'),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSplashPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: width / 3,
                    width: width / 3,
                    child: Image.asset(
                      ImagesAssets.movieIcon,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FutureBuilder<String>(
                future: _getVersion(),
                builder: (context, snapshot) {
                  var verInfo = '';
                  if (snapshot.hasData) {
                    verInfo = 'v ${snapshot.data}';
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      verInfo,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
