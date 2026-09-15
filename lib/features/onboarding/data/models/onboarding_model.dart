import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_string.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String ?description;
  final Color gradientColor;

  OnboardingModel({
    required this.image,
    required this.title,
    this.description,
    required this.gradientColor,
  });
}
  final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: AppAssets.TheAvengers,
      title: AppString.discoverMovies,
      description: AppString.discoverMoviesDescription,
      gradientColor:AppColors.blue,
    ),

    OnboardingModel(
      image: AppAssets.TheGodfather,
      title: AppString.exploreAllGenres,
      description: AppString.exploreAllGenresDescription,
      gradientColor:AppColors.orange,
    ),

    OnboardingModel(
      image: AppAssets.badBoys,
      title: AppString.createWatchlists,
      description: AppString.createWatchlistsDescription,
      gradientColor: AppColors.purple,
    ),

    OnboardingModel(
      image: AppAssets.DoctorStrange,
      title: AppString.rateReviewAndLearn,
      description: AppString.rateReviewAndLearnDescription,
      gradientColor:AppColors.burgundy,
    ),

    OnboardingModel(
      image: AppAssets.film1917,
      title: AppString.startWatchingNow,
      gradientColor:AppColors.grayliner,
    ),


  ];

