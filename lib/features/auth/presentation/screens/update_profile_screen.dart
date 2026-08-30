import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/theme/app_assets.dart';
import 'package:moviesproject/core/theme/app_colors.dart';
import 'package:moviesproject/core/theme/app_string.dart';
import 'package:moviesproject/core/theme/app_text_style.dart';
import 'package:moviesproject/features/auth/presentation/widgets/avatar_bottom_sheet.dart';


import 'package:moviesproject/features/auth/presentation/widgets/avatarcarousel.dart';

import 'package:moviesproject/features/auth/presentation/widgets/custom_button .dart';
import 'package:moviesproject/features/auth/presentation/widgets/customtextfield.dart';

class UpdateProfileScreen extends StatefulWidget{
  const UpdateProfileScreen({super.key});
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
  }

  class _UpdateProfileScreenState extends State<UpdateProfileScreen>{

    String selectedAvatar = AppAssets.avaterone;

    final List<String> avtars = [
      AppAssets.avaterone,
      AppAssets.avatertwo,
      AppAssets.avaterthree,
      AppAssets.avaterfour,
      AppAssets.avaterfive,
      AppAssets.avatersix,
      AppAssets.avaterseven,
      AppAssets.avatereight,
      AppAssets.avaternine,
    ];

    void showAvatarBottomSheet (){
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return AvatarBottomSheet(avtars: avtars,
            selectedAvatar: selectedAvatar,
            onAvaterSelected: (avtars){
              setState( (){
                selectedAvatar =avtars;
              });
            },
          );
        },);
    }

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
        title:Text( AppString.pickavatar,
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
            return  Padding(
              padding:  EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                top: 15,
                bottom: 0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: contentWidth,
                ),
                child: Column(
                  children: [
                    //avter
                  GestureDetector(
                    onTap:showAvatarBottomSheet ,
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: ClipOval(
                        child: Image.asset(selectedAvatar,fit: BoxFit.cover,),
                      ),
                    ),
                  ),


                    SizedBox(height: screenHeight <700 ?30 :45 ,),
                    //name
                    CustomTextField(hintText: AppString.johnsafwat,
                        prefixIcon: AppAssets.User),
                     SizedBox(height: 16),
                    //email
                    CustomTextField(hintText: '01200000000',
                        prefixIcon: AppAssets.phone),
                     SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(onPressed: (){},
                        child: Text(AppString.resetpassword,style: AppTextStyle.regular20white,),),
                    ),
                    Spacer(),
                    CustomButton(text: AppString.deleteaccount, onPressd: (){},backgroundColor :AppColors.red),
                     SizedBox(height: 16),
                    CustomButton(text: AppString.updatedata, onPressd: (){}),


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