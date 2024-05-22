import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nishauri/src/utils/helpers.dart';

class RatingBar extends StatelessWidget {
  final int? rating;
  final int minRating;
  final int maxRating;
  final Function(int rating)? onRatingChange;
  final spacing;

  const RatingBar(
      {super.key,
      this.rating,
      this.onRatingChange,
      this.minRating = 1,
      this.spacing = 0.0,
      this.maxRating = 6});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      children: range(minRating, maxRating)
          .map(
            (e) => IconButton(
              onPressed: () {
                if (onRatingChange != null) onRatingChange!(e);
              },
              icon: FaIcon(
                  rating != null && rating! >= e
                      ? FontAwesomeIcons.solidStar
                      : FontAwesomeIcons.star,
                  color: Colors.orange),
            ),
          )
          .toList(),
    );
  }
}
