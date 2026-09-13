import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';

class RatingBadge extends StatelessWidget {
  final double rating;

  const RatingBadge({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.blackopacity65,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyle.bold12white
          ),

          const SizedBox(width: 3),

           Icon(
            Icons.star,
            color:AppColors.gold,
            size: 14,
          ),
        ],
      ),
    );
  }
}