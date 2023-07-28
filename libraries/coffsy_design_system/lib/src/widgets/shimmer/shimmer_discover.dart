import 'package:flutter/material.dart';

class ShimmerDiscover extends StatelessWidget {
  const ShimmerDiscover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: width / 1.4,
      width: width / 2,
    );
  }
}
