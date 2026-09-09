import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/features/auth/presentation/screens/login_screen.dart';
import 'package:moviesproject/features/auth/presentation/screens/register_screen.dart';
import 'package:moviesproject/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:moviesproject/features/auth/presentation/screens/update_profile_screen.dart';
import 'package:moviesproject/l10n/app_localizations.dart';
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

class MyApp extends StatefulWidget {
  final bool onboardingSeen;
  const MyApp({super.key,required this.onboardingSeen,});
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  Locale currentLocale = const Locale('en');
  @override
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

  void changeLanguage(String languageCode) {
    setState(() {
      currentLocale = Locale(languageCode);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie',
      debugShowCheckedModeBanner:false,


      locale: currentLocale,

      localizationsDelegates:
      AppLocalizations.localizationsDelegates,

      supportedLocales:
      AppLocalizations.supportedLocales,
     routes: {
       AppRoutes.resetPasswordScreen:(_)=>ResetPasswordScreen(),
       AppRoutes.onboardingScreen:(_)=>Onboardingscreen(),
       AppRoutes.loginScreen: (_) =>  LoginScreen( onLanguageChanged: changeLanguage,),
       AppRoutes.registerScreen: (_) =>  RegisterScreen(  onLanguageChanged: changeLanguage,
       ),
       AppRoutes.homescreen: (_) =>  Homescreen(),
       AppRoutes.updateProfileScreen: (_) =>  UpdateProfileScreen(),
       //tabs
       //AppRoutes.homeTab: (context) =>  Hometab(),
       //AppRoutes.searchTab: (context) =>  SearchTab(),
      // AppRoutes.browseTab: (context) =>  BrowseTab(),
      // AppRoutes.profileTab: (context) =>  ProfileTab(),
     },
      initialRoute: widget.onboardingSeen
          ? FirebaseAuth.instance.currentUser==null ?AppRoutes.loginScreen:AppRoutes.homescreen
          : AppRoutes.onboardingScreen,
    );
  }
}

