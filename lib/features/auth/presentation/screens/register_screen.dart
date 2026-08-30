import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/theme/app_assets.dart';
import 'package:moviesproject/core/theme/app_colors.dart';
import 'package:moviesproject/core/theme/app_string.dart';
import 'package:moviesproject/core/theme/app_text_style.dart';
import 'package:moviesproject/features/auth/presentation/screens/update_profile_screen.dart';
import 'package:moviesproject/features/auth/presentation/widgets/avatarcarousel.dart';

import 'package:moviesproject/features/auth/presentation/widgets/custom_button .dart';
import 'package:moviesproject/features/auth/presentation/widgets/customtextfield.dart';
import 'package:moviesproject/features/auth/presentation/widgets/flag/egypt_flag.dart';
import 'package:moviesproject/features/auth/presentation/widgets/flag/liberia_flag.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen>
  {
    bool isPasswordVisible =false;
    bool isFlafSelected = true;


    @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.darkblack,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(
            Icons.arrow_back,
            color: AppColors.yellow,
            size: 32,
          ),),
        ),
        title:Text( AppString.register,
        style: AppTextStyle.regular16yellow,
      ),),
      backgroundColor: AppColors.darkblack,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context,constraints){
            final screenWidth =constraints.maxWidth;
            final screenHeight =constraints.maxHeight;
            final horizontalPadding =screenWidth <400 ?16.0 :24.0;
            final contentWidth =screenWidth >500 ?420.0 :screenWidth -(horizontalPadding*2);
            // final logoSize =(screenWidth *0.30).clamp(90.0, 121.0);
            return SingleChildScrollView(
              padding:  EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                top: 0,
                bottom: 0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: contentWidth,
                ),
                child: Column(
                  children: [
                    //avter
                     AvatarCarousel(images: [
                      AppAssets.avaterone,
                       AppAssets.avatertwo,
                       AppAssets.avaterthree,
                       AppAssets.avaterfour,
                       AppAssets.avaterfive,
                       AppAssets.avatersix,
                       AppAssets.avaterseven,
                       AppAssets.avatereight,
                       AppAssets.avaternine,

                     ]),
                    SizedBox(height: screenHeight <700 ?30 :45 ,),
                    //name
                    CustomTextField(hintText: AppString.name,
                        prefixIcon: AppAssets.name),
                    const SizedBox(height: 16),
                    //email
                    CustomTextField(hintText: AppString.email,
                        prefixIcon: AppAssets.Email),
                    const SizedBox(height: 16),
                    //password
                    CustomTextField(hintText: AppString.password,
                      prefixIcon: AppAssets.Password,
                      obscureText: !isPasswordVisible,
                      suffIcon: IconButton(onPressed: (){
                        setState(() {
                          isPasswordVisible =!isPasswordVisible;
                        });
                      }, icon: Icon(
                        isPasswordVisible ?Icons.visibility :Icons.visibility_off,
                        color :AppColors.white,
                      ),),
                    ),
                    const SizedBox(height: 16),
                    //confirampassword
                    CustomTextField(hintText: AppString.confirmpassword,
                      prefixIcon: AppAssets.Password,
                      obscureText: !isPasswordVisible,
                      suffIcon: IconButton(onPressed: (){
                        setState(() {
                          isPasswordVisible =!isPasswordVisible;
                        });
                      }, icon: Icon(
                        isPasswordVisible ?Icons.visibility :Icons.visibility_off,
                        color :AppColors.white,
                      ),),
                    ),
                    const SizedBox(height: 16),

                    //phone
                    CustomTextField(hintText: AppString.phonenumber,
                        prefixIcon: AppAssets.phone),
                    const SizedBox(height: 16),

                    CustomButton(text: AppString.createaccount, onPressd: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder:
                          (context)=>  UpdateProfileScreen(),),);
                    }),
                    const SizedBox(height: 18),
                    RichText(text:  TextSpan(
                      text:AppString.alreadyhaveaccount,
                      style: AppTextStyle.regular14white,
                      children: [
                        TextSpan(
                            text:AppString.login,
                            style:AppTextStyle.regular14yellow,
                            recognizer: TapGestureRecognizer()
                              ..onTap =(){}
                        ),
                      ],
                    ),),

                    const SizedBox(height: 28),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isFlafSelected = !isFlafSelected;
                        });
                      },
                      child: Container(
                        width: 90.72,
                        height: 38.08,
                        decoration: BoxDecoration(color: AppColors.darkblack,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: AppColors.yellow,width: 2,
                          ),),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 200),
                              left:isFlafSelected ?-2 :null,
                              right: isFlafSelected ? null :-2,
                              top: -2,
                              child: Container(
                                width: 40.08,
                                height: 38.08,
                                decoration: BoxDecoration(
                                  color: AppColors.yellow,
                                  shape: BoxShape.circle,
                                ),

                              ),),
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 200),

                              left:isFlafSelected ?1:7,
                              top:isFlafSelected ?1:7,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isFlafSelected =true;
                                  });
                                },
                                child: AnimatedContainer(duration: Duration(milliseconds: 200),
                                  width: isFlafSelected ?34 :26,
                                  height: isFlafSelected ?34 :26,
                                  child: const LiberiaFlag(),),
                              ),),
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 200),

                              right:isFlafSelected ?7:1,
                              top:isFlafSelected ?7:1,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isFlafSelected =true;
                                  });
                                },
                                child: AnimatedContainer(duration: Duration(milliseconds: 200),
                                  width: isFlafSelected ?26 :34,
                                  height: isFlafSelected ?26 :34,
                                  child: const EgyptFlag(),),
                              ),),
                          ],
                        ),
                      ),
                    )
                  ],

                ),
              ),
            );

          },
          // child: Container(
          //   width: double.infinity,
          //   color: AppColors.darkblack,
          // ),
        ),),
    );

  }

  }

