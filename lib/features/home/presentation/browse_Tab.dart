import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';

import '../../../core/constants/app_string.dart';
class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColors.darkblack,
      body: SizedBox(
        child:Center(
          child:Text(AppString.Browse,style:TextStyle(color:Colors.red),) ,
        )
      ),
    );
  }
}