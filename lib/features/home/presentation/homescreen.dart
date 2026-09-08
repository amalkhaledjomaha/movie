import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/features/home/presentation/profile_Tab.dart';
import 'package:moviesproject/features/home/presentation/search_Tab.dart';
import 'package:moviesproject/features/home/presentation/browse_Tab.dart';
import 'package:moviesproject/features/home/presentation/homeTab.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;
  final List<Widget> tabs = const [
    Hometab(),
     SearchTab(),
     BrowseTab(),
      ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkblack,
      //مش مطلوب
      appBar: AppBar(
        title: const Text("Move App ", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginScreen,
                (route) => false,
              );
            },
            icon: Icon(Icons.login_sharp),
          ),
        ],
      ),

      body:tabs[selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
