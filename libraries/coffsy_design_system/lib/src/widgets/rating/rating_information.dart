import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class RatingInformation extends StatelessWidget {
  final double rating;

  const RatingInformation({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var numericRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          rating.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.secondary,
            fontSize: Sizes.dp16(context),
          ),
        ),
        SizedBox(height: Sizes.dp4(context)),
        const Text(
          'Ratings',
        ),
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RatingBar(theme, context, rating),
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

class RatingBar extends StatefulWidget {
  final ThemeData theme;
  final BuildContext _context;
  final double rating;

  const RatingBar(this.theme, this._context, this.rating, {Key? key}) : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  final stars = <Widget>[];

  void calculateStars() {
    for (var i = 1; i <= 5; i++) {
      var color = i <= widget.rating / 2 ? widget.theme.colorScheme.secondary : ColorPalettes.grey;
      var star = Icon(
        Icons.star,
        color: color,
        size: Sizes.dp18(widget._context),
      );
      stars.add(star);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    calculateStars();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}
