import 'package:flutter/material.dart';

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
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
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
        const Padding(
          padding: EdgeInsets.only(top: 4, left: 4),
          child: Text(
            'Grade now',
          ),
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        numericRating,
        const SizedBox(width: 16),
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
