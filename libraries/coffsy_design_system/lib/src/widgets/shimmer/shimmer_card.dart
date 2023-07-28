import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../coffsy_design_system.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Shimmer.fromColors(
      baseColor: ColorPalettes.greyBg,
      highlightColor: ColorPalettes.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 10 / 16,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorPalettes.greyBg,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: width / 1.8,
              width: width / 2.5,
              decoration: BoxDecoration(
                color: ColorPalettes.greyBg,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: width / 1.8,
              width: width / 2.5,
              decoration: BoxDecoration(
                color: ColorPalettes.greyBg,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
