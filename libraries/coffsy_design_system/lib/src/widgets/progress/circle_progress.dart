import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class CircleProgress extends StatelessWidget {
  final String vote;

  const CircleProgress({
    Key? key,
    required this.vote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _vote = double.parse(vote);

    final width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: width / 10,
      height: width / 10,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: width / 10,
              height: width / 10,
              decoration: BoxDecoration(
                color: ColorPalettes.blueGrey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorPalettes.getColorCircleProgress(
                    double.parse(vote),
                  ),
                ),
                backgroundColor: ColorPalettes.grey,
                value: _vote / 10.0,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: Text(
                  '${(_vote * 10.0).floor()}%',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: ColorPalettes.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
