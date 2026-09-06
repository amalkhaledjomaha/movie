 import 'dart:ui';
 import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {
   static final TextStyle medium36white = TextStyle(
     fontSize:36,
     fontWeight: FontWeight.w500,
     color:AppColors.white,
   );

   static final TextStyle regular20white = TextStyle(
     fontSize:20,
     fontWeight: FontWeight.w400,
     color:AppColors.white.withValues(alpha: 0.6),
   );

   static final TextStyle regular20whitewithoutalpha = TextStyle(
     fontSize:20,
     fontWeight: FontWeight.w400,
     color:AppColors.white,
   );

   static final TextStyle regular18white = TextStyle(
     fontSize:18,
     fontWeight: FontWeight.w400,
     color:AppColors.white,
   );


   static final TextStyle regular20black = TextStyle(
     fontSize:20,
     fontWeight: FontWeight.w400,
     color:AppColors.black,
   );

   static final TextStyle regular16yellow = TextStyle(
     fontSize:16,
     fontWeight: FontWeight.w400,
     color:AppColors.yellow,
   );

   static final TextStyle regular16white = TextStyle(
     fontSize:16,
     fontWeight: FontWeight.w400,
     color:AppColors.white,
   );

   static final TextStyle  SemiBold20darkblack = TextStyle(
     fontSize:20,
     fontWeight: FontWeight.w600,
     color:AppColors.darkblack,
   );

   static final TextStyle  SemiBold20darkyellow = TextStyle(
     fontSize:20,
     fontWeight: FontWeight.w600,
     color:AppColors.yellow,
   );

   static final TextStyle  Bold24white = TextStyle(
     fontSize:24,
     fontWeight: FontWeight.w700,
     color:AppColors.white,
   );




   static final TextStyle regular14yellow = TextStyle(
     fontSize:14,
     fontWeight: FontWeight.w400,
     color:AppColors.yellow,
   );


   static final TextStyle regular16black = TextStyle(
     fontSize:16,
     fontWeight: FontWeight.w400,
     color:AppColors.black,
   );

   static final TextStyle regular14white = TextStyle(
     fontSize:14,
     fontWeight: FontWeight.w400,
     color:AppColors.white,
   );

   static final TextStyle  Bold24black = TextStyle(
     fontSize:24,
     fontWeight: FontWeight.w700,
     color:AppColors.black,
   );


   static final TextStyle regular16red = TextStyle(
     fontSize:16,
     fontWeight: FontWeight.w400,
     color:AppColors.red,
   );
 }

