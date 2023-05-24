import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class RatingInformation extends StatelessWidget {
  final double rating;

  const RatingInformation({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numericRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          rating.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.secondary,
            fontSize: Sizes.dp16(context),
          ),
        ),
        SizedBox(height: Sizes.dp4(context)),
        const Text(
          'Ratings',
        ),
      ],
    );

    final starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RatingBar(rating),
        Padding(
          padding: EdgeInsets.only(top: Sizes.dp4(context), left: Sizes.dp4(context)),
          child: const Text(
            'Grade now',
          ),
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        numericRating,
        SizedBox(width: Sizes.dp16(context)),
        starRating,
      ],
    );
  }
}

class RatingBar extends StatelessWidget {
  final double rating;

  const RatingBar(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(5, (i) {
        final color = i < rating ? _colorScheme.secondary : _colorScheme.onSurface;

        return Icon(
          Icons.star,
          color: color,
          size: 18,
        );
      }),
    );
  }
}
