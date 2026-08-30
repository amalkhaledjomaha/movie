import 'package:flutter/material.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/onboarding/presentation/screens/OnboardingContentPage.dart';
import 'features/onboarding/presentation/screens/OnboardingFirstPage.dart';
import 'features/onboarding/presentation/screens/OnboardingScreen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final bool onboardingSeen =
      prefs.getBool('onboardingSeen') ?? false;

  runApp(
    MyApp(
      onboardingSeen: onboardingSeen,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboardingSeen;
  const MyApp({super.key,required this.onboardingSeen,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie',
      debugShowCheckedModeBanner:false,

     routes: {
       AppRoutes.resetPasswordScreen:(_)=>ResetPasswordScreen(),
       AppRoutes.onboardingScreen:(_)=>Onboardingscreen(),
     },
      initialRoute: onboardingSeen
          ? AppRoutes.resetPasswordScreen
          : AppRoutes.onboardingScreen,
    );
  }
}

