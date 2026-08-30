import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/theme/app_assets.dart';
import 'package:moviesproject/core/theme/app_colors.dart';
import 'package:moviesproject/core/theme/app_string.dart';
import 'package:moviesproject/core/theme/app_text_style.dart';

class CustomTextField extends StatelessWidget{
  final String hintText;
  final String prefixIcon;
  final bool obscureText;
  final Widget ?suffIcon;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText =false,
    this.suffIcon,
});
  @override
  Widget build(BuildContext context) {
   return TextField(

     obscureText :obscureText,
     style: AppTextStyle.regular16white,
     decoration:  InputDecoration(
       hintText: hintText,
       hintStyle:AppTextStyle.regular16white,

       prefixIcon: Padding(padding: const EdgeInsets.all(12),
         child: Image.asset(prefixIcon),),
       suffixIcon:suffIcon,
       filled: true,
       fillColor: AppColors.black,
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(14),
         borderSide: BorderSide.none,
       ),
     ),
   );

  }

}