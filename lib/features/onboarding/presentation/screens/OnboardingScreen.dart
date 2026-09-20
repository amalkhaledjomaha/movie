import 'package:flutter/material.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import '../../data/models/onboarding_model.dart';
import 'OnboardingContentPage.dart';
import 'OnboardingFirstPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  final PageController pageController = PageController();
  Future<void> finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('onboardingSeen', true);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: onboardingList.length+1,
        itemBuilder: (context, index) {
          if(index==0){
            return Onboardingfirstpage(
              onExplore: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            );
          }
          final model = onboardingList[index - 1];

          final bool isLastPage =
              index == onboardingList.length;

          return Onboardingcontentpage(
            model: model,

            isLastPage: isLastPage,

            onNext: () async {
              if (isLastPage) {
                await finishOnboarding();
                //login
               Navigator.of(context).pushNamed(AppRoutes.loginScreen);
              } else {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },

            onBack: index >= 2
                ? () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
                : null,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}