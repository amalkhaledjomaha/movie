import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';

import 'package:moviesproject/core/constants/app_text_style.dart';
class CustomButton  extends StatelessWidget{
  final String text;
  final VoidCallback onPressd;
  final Color ? backgroundColor;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressd,
    this.backgroundColor
});
  @override
  Widget build(BuildContext context) {
   return   SizedBox(
     width: double.infinity,
     height: 56,
     child: ElevatedButton(onPressed: onPressd,
         style: ElevatedButton.styleFrom(
           backgroundColor: backgroundColor ??AppColors.yellow,
           foregroundColor: AppColors.darkblack,
           elevation: 0,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(14),
           ),
         ),
         child:  Text(text,style: AppTextStyle.regular16black,)),
   );
  }

}