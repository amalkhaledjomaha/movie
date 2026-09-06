import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import '../../../core/constants/app_string.dart';
class Hometab extends StatelessWidget {
  const Hometab({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColors.darkblack,
      body: SizedBox(
          child:Center(
            child:Text(AppString.home,style:TextStyle(color:Colors.red),) ,
          )
      ),
    );
  }
}
