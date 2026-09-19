import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/l10n/app_localizations.dart';

import '../../../../core/constants/app_colors.dart';

class Onboardingfirstpage extends StatelessWidget {
  final VoidCallback onExplore;
  const Onboardingfirstpage({super.key, required this.onExplore,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkblack,
      body: Stack(
        children: [
          Image.asset(
            AppAssets.OnBoardingscreen,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.0,
                  0.10,
                  0.68,
                  1.0,
                ],
                colors: [
                  AppColors.White,
                  AppColors.gray,
                  AppColors.darkgray,
                  AppColors.darkblack,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.findYourNextFavoriteMovie,
                  style: AppTextStyle.medium36white,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.getAccessToHugeLibrary,
                  style: AppTextStyle.regular20white,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed:
                    onExplore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.exploreNow,
                    style: AppTextStyle.SemiBold20darkblack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
