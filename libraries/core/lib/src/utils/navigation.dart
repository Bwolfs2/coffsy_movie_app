import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Navigation {
  static back(BuildContext context) {
    Navigator.pop(context);
  }

  static intent(BuildContext context, String nameRouted) {
    Modular.to.pushNamed(nameRouted);
  }

  static intentWithoutBack(BuildContext context, String nameRouted) {
    Modular.to.navigate(nameRouted, replaceAll: true);
  }

  static intentWithClearAllRoutes(BuildContext context, String nameRouted) {
    Modular.to.navigate(nameRouted, replaceAll: true);
  }

  static intentWithData(BuildContext context, String nameRouted, Object argumentClass) {
    Modular.to.pushNamed(nameRouted, arguments: argumentClass);
  }

  // URL valid for this plugin only are
  // https://www.flutter.dev
  // http://www.flutter.dev
  // https://flutter.dev
  // http://flutter.dev
  //
  // For this it's not working
  // www.flutter.dev
  // flutter.dev
  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
