import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import '../../../core/constants/app_string.dart';
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColors.darkblack,
      body: SizedBox(
          child:Center(
            child:Text(AppString.Profile,style:TextStyle(color:Colors.red),) ,
          )
      ),
    );
  }
}