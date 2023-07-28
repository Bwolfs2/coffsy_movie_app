import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../coffsy_design_system.dart';

class ShimmerBanner extends StatelessWidget {
  const ShimmerBanner({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: ColorPalettes.greyBg,
        highlightColor: ColorPalettes.white,
        child: Column(
          children: [
            Container(
              height: width / 2,
              width: width,
              decoration: BoxDecoration(
                color: ColorPalettes.greyBg,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            ),
            Row(
              children: [
                Container(
                  width: width / 3,
                  height: 8,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 2,
                  ),
                  color: ColorPalettes.greyBg,
                ),
                const Spacer(),
                Container(
                  height: 8,
                  width: width / 8,
                  color: ColorPalettes.greyBg,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
