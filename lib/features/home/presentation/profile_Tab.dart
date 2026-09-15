import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/l10n/app_localizations.dart';
import '../../../core/constants/app_string.dart';
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColors.darkblack,
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.movieapp, style: TextStyle(color: Colors.white)),
        backgroundColor:AppColors.darkblack,
        actions: [
          //التعديل
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
          //
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

      body: SizedBox(
          child:Center(
            child:Text( AppLocalizations.of(context)!.profile,style:TextStyle(color:Colors.red),) ,
          )
      ),
    );
  }
}