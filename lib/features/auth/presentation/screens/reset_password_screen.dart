import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkblack,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: AppColors.yellow,
        ),
        title: Text(
          AppString.forgetPassword,
          style: AppTextStyle.regular16yellow,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.darkblack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.asset(
                  AppAssets.Forgot_password,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.black,
                    hint: Text(
                      AppString.email,
                      style: AppTextStyle.regular16white,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        AppAssets.email,
                        height: 25,
                        width: 31,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 31,
                      minHeight: 25,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppColors.yellow,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right:16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style:ElevatedButton.styleFrom(
                    backgroundColor:AppColors.yellow,
                      shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  child: Text(AppString.verifyEmail,style:AppTextStyle.regular20black,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
