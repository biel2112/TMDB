import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/utils/app_colors.dart';

class Rating extends StatelessWidget {
  final double rating;

  const Rating({
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double normalizedScore = rating.clamp(0, 10);
    int filledStars = (normalizedScore / 2).round();
    bool hasHalfStar = filledStars < (normalizedScore / 2);

    return Row(
      children: List.generate(5, (index) {
        if (index < filledStars) {
          return const Icon(Icons.star,
              size: 15, color: AppColors.ratingFullColor);
        } else if (hasHalfStar && index == filledStars) {
          return const Icon(Icons.star_half,
              size: 15, color: AppColors.ratingFullColor);
        } else {
          return const Icon(Icons.star,
              size: 15, color: AppColors.ratingEmptyColor);
        }
      }),
    );
  }
}
