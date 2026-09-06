import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/features/auth/presentation/screens/login_screen.dart';
import 'package:moviesproject/features/auth/presentation/screens/register_screen.dart';
import 'package:moviesproject/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:moviesproject/features/auth/presentation/screens/update_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/home/presentation/browse_Tab.dart';
import 'features/home/presentation/homeTab.dart';
import 'features/home/presentation/homescreen.dart';
import 'features/home/presentation/profile_Tab.dart';
import 'features/home/presentation/search_Tab.dart';
import 'features/onboarding/presentation/screens/OnboardingScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool onboardingSeen =
      prefs.getBool('onboardingSeen') ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(
      onboardingSeen: onboardingSeen,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboardingSeen;
  const MyApp({super.key,required this.onboardingSeen,});

  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('==========================User is currently signed out!');
      } else {
        print('==========================User is signed in!');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie',
      debugShowCheckedModeBanner:false,

     routes: {
       AppRoutes.resetPasswordScreen:(_)=>ResetPasswordScreen(),
       AppRoutes.onboardingScreen:(_)=>Onboardingscreen(),
       AppRoutes.loginScreen: (_) =>  LoginScreen(),
       AppRoutes.registerScreen: (_) =>  RegisterScreen(),
       AppRoutes.homescreen: (_) =>  Homescreen(),
       AppRoutes.updateProfileScreen: (_) =>  UpdateProfileScreen(),
       //tabs
       AppRoutes.homeTab: (context) =>  Hometab(),
       AppRoutes.searchTab: (context) =>  SearchTab(),
       AppRoutes.browseTab: (context) =>  BrowseTab(),
       AppRoutes.profileTab: (context) =>  ProfileTab(),
     },
      initialRoute: onboardingSeen
          ? FirebaseAuth.instance.currentUser==null ?AppRoutes.loginScreen:AppRoutes.homescreen
          : AppRoutes.onboardingScreen,
    );
  }
}

