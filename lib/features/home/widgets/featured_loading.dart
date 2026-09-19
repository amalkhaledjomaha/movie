import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/widgets/rating_badge.dart';
class FeaturedLoading extends StatelessWidget {
  const FeaturedLoading();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,

      child: Center(
        child: Container(
          width: 175,
          height: 270,

          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius:
            BorderRadius.circular(17),
          ),

          child:  Center(
            child: CircularProgressIndicator(
              color:AppColors.gold,
            ),
          ),
        ),
      ),
    );
  }
}
