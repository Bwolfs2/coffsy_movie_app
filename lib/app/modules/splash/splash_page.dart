import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info/package_info.dart';

/// SplashPage
/// <img src="https://raw.githubusercontent.com/rrifafauzikomara/MovieApp/master/screenshot/ios1.png" width="300">
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<String> _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  _startSplashPage() async => await Future.delayed(
        const Duration(seconds: 3),
        () => Modular.to.navigate('/dashboard/movie_module/'),
      );

  @override
  void initState() {
    super.initState();
    _startSplashPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Sizes.width(context) / 3,
                    width: Sizes.width(context) / 3,
                    child: Image.asset(
                      ImagesAssets.movieIcon,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
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
                    margin: EdgeInsets.only(bottom: Sizes.dp30(context)),
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
