import 'package:flutter/material.dart';

import 'rating_progress_indicator.dart';

class OverAllProductRating extends StatelessWidget {
  const OverAllProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '3.5',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              RatingProgressIndicator(text: '5', value: 1.0),
              RatingProgressIndicator(text: '4', value: 0.75),
              RatingProgressIndicator(text: '3', value: 0.5),
              RatingProgressIndicator(text: '2', value: 0.25),
              RatingProgressIndicator(text: '1', value: 0.0),
            ],
          ),
        )
      ],
    );
  }
}
