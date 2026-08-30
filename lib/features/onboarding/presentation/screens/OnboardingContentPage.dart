import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/routes/app_routes.dart';
import '../../data/models/onboarding_model.dart';

class Onboardingcontentpage extends StatelessWidget {
  final OnboardingModel model;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool isLastPage;
  const Onboardingcontentpage({
    super.key,
    required this.model,
    required this.onNext,
    this.onBack,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkblack,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.75,
            child: Image.asset(
            model.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.75,
            child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  model.gradientColor.withOpacity(0.0),
                  model.gradientColor.withOpacity(1.0),
                ],
              ),
            ),
          ),),

         Align(
           alignment: Alignment.bottomCenter,
           child:Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.darkblack,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    model.title,
                    style: AppTextStyle.Bold24white,
                    textAlign: TextAlign.center,
                  ),


                  if (model.description != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      model.description!,
                      style: AppTextStyle.regular18white,
                      textAlign: TextAlign.center,
                    ),
                  ],

                  const SizedBox(height: 8),

                  ElevatedButton(
                    onPressed:onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    child: Text(
                      isLastPage ? AppString.finish :AppString.next,
                      style: AppTextStyle.SemiBold20darkblack,
                    ),
                  ),
                  if (onBack != null) ...[
                    const SizedBox(height: 12),

                    OutlinedButton(
                      onPressed: onBack,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.darkblack,
                        side: const BorderSide(
                          color: AppColors.yellow,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(
                          double.infinity,
                          55,
                        ),
                      ),
                      child: Text(
                        AppString.back,
                        style: AppTextStyle.SemiBold20darkyellow,
                      ),
                    ),
                  ],
                ],
              ),
            ),
         ),
        ],
      ),
    );
  }
}
