import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../coffsy_design_system.dart';

class ChairConstant {
  static Widget grey = const GreyChair();
  static Widget red = const RedChair();
  static Widget orange = const OrangeChair();
  static const _whiteDark = WhiteChairDark();
  static const _whiteLight = WhiteChairLight();
  static Widget white({bool isDarkTheme = false}) => isDarkTheme ? _whiteLight : _whiteDark;
}

class WhiteChairDark extends StatelessWidget {
  const WhiteChairDark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalettes.white,
          border: Border.all(
            color: ColorPalettes.transparent,
          ),
        ),
        child: SvgPicture.asset(ImagesAssets.chairDark),
      ),
    );
  }
}

class WhiteChairLight extends StatelessWidget {
  const WhiteChairLight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalettes.white,
          border: Border.all(
            color: ColorPalettes.grey,
          ),
        ),
        child: SvgPicture.asset(ImagesAssets.chairDark),
      ),
    );
  }
}

class GreyChair extends StatelessWidget {
  const GreyChair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[800]),
        child: SvgPicture.asset(ImagesAssets.chairLight),
      ),
    );
  }
}

class RedChair extends StatelessWidget {
  const RedChair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[900],
        ),
        child: SvgPicture.asset(ImagesAssets.chairLight),
      ),
    );
  }
}

class OrangeChair extends StatelessWidget {
  const OrangeChair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Container(
        decoration: BoxDecoration(color: ColorPalettes.darkAccent),
        child: SvgPicture.asset(ImagesAssets.chairDark),
      ),
    );
  }
}
