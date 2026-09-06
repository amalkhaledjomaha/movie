import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import 'package:moviesproject/core/constants/app_colors.dart';

import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
class CustomTextField extends StatelessWidget{
  final String hintText;
  final String prefixIcon;
  final bool obscureText;
  final Widget ?suffIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText =false,
    this.suffIcon,
    this.controller,
    this.validator
});
  @override
  Widget build(BuildContext context) {
   return TextFormField(
     controller: controller,
     validator: validator,
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