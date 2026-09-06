import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.darkblack,
        title: const Text("Move App ",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.updateProfileScreen,
              );
            },
            icon: const Icon(
              Icons.edit,
              color: AppColors.yellow,
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false,);
            },
            icon: Icon(Icons.login_sharp),
          ),

        ],
      ),
    );
  }
}
