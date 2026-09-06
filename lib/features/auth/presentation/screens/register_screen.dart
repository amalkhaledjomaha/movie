import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_assets.dart';

import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
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
    bool isPasswordVisible = false;
    bool isConfirmPasswordVisible = false;
    bool isFlafSelected = true;
    bool isLoading =false;
    final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
    final TextEditingController nameController =TextEditingController();
    final TextEditingController emailController =TextEditingController();
    final TextEditingController passwordController =TextEditingController();
    final TextEditingController confirmPasswordController =TextEditingController();
    final TextEditingController phoneController =TextEditingController();

String selectedAvatar =AppAssets.avaterone;
    final List<String> avatars = [
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
    @override
    void dispose(){
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
      phoneController.dispose();
      super.dispose();
    }

    Future<void> createAccount() async{
      if( !_formkey.currentState!.validate()){
        return;
      }
      try {
        setState(() {
          isLoading = true;
        });
        final UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        final User? user = userCredential.user;
        if (user == null) {
          showMessage('Account could not be created');
          return;
        }

        await user.updateDisplayName(
          nameController.text.trim(),
        );


        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({'uid': user.uid,
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'phone': phoneController.text.trim(),
          'avatar': selectedAvatar,
          });

        if (!mounted) return;
        showMessage(AppString.accountcreatedsuccessfully);

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.homescreen,
              (route) => false,
        );
      } on FirebaseAuthException catch(e) {
        String message;

        String getErrorMessage(FirebaseAuthException e) {
          switch (e.code) {
            case 'weak-password':
              return AppString.weakpassword;
            case 'email-already-in-use':
              return AppString.emailalreadyinuse;
            case 'invalid-email':
              return AppString.invalidemail;
            case 'operation-not-allowed':
              return AppString.operationnotallowed;
            case 'network-request-failed':
              return AppString.networkrequestfailed;
            default:
              return e.message ?? AppString.somethingwentwrong;
          }
        }
      }
      catch(e){
          debugPrint('ERROR: $e');
          showMessage(e.toString());}
      finally
          {
            if(mounted){
              setState(() {
                isLoading =false;
              });
            }
          }

      }

    Future<void> showMessage(String message) async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.darkblack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
                const SizedBox(height: 15),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular16white,
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: AppTextStyle.regular16yellow,
                  ),
                ),
              ],
            ),
          );
        },
      );
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
                child: Form(
key: _formkey,
                  child: Column(
                    children: [
                      //avter
                       AvatarCarousel(
                images :avatars,
onAvatarSelected :(avatar)
{
selectedAvatar=avatar;
},
),
                      SizedBox(height: screenHeight <700 ?30 :45 ,),
                      //name
                      CustomTextField(
                        controller: nameController,

                   hintText: AppString.name,
                          prefixIcon: AppAssets.name,
                  validator: (value) {
if (value == null || value.trim().isEmpty) {
return AppString.nameisrequired;
}
if (value.trim().length < 3) {
  return AppString.namemustbeatleast3characters; }
return null;
},),
                      const SizedBox(height: 16),
                      //email
                      CustomTextField(
                    controller: emailController,
                    hintText: AppString.email,
                    prefixIcon: AppAssets.Email,
validator: (value) {
if (value == null || value.trim().isEmpty) {
return   AppString.emailisrequired;

}

if (!value.contains('@')) {
return AppString.enteravalidemail ;
}

return null;
},),

                      const SizedBox(height: 16),
                      //password
                      CustomTextField(
                        controller: passwordController,
                       hintText: AppString.password,
                        prefixIcon: AppAssets.Password,
                        obscureText: !isPasswordVisible,
validator: (value) {
if (value == null || value.isEmpty) {
return AppString.passwordisrequired;
}

if (value.length < 6) {
return AppString.passwordmustbeatleast6characters;
}

return null;
},
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
                      CustomTextField(
                        controller: confirmPasswordController,
                        hintText: AppString.confirmpassword,
                        prefixIcon: AppAssets.Password,
                        obscureText: !isConfirmPasswordVisible,
validator: (value) {
if (value == null || value.isEmpty) {
return AppString.confirmpassword;
}

if (value != passwordController.text) {
return AppString.passwordsdonotmatch;
}

return null;
},
                        suffIcon: IconButton(onPressed: (){
                          setState(() {
                            isConfirmPasswordVisible =!isConfirmPasswordVisible;
                          });
                        }, icon: Icon(
                          isConfirmPasswordVisible ?Icons.visibility :Icons.visibility_off,
                          color :AppColors.white,
                        ),),
                      ),
                      const SizedBox(height: 16),

                      //phone
                      CustomTextField(
                      controller: phoneController,

                      hintText: AppString.phonenumber,
                          prefixIcon: AppAssets.phone,
validator: (value) {
if (value == null || value.trim().isEmpty) {
return AppString.phoneisrequired;
}
if (value.length < 10) {
return AppString.phonethan10;
}
if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
  return AppString.invalidphone;
}
return null;
},),
                      const SizedBox(height: 16),

                      CustomButton(
                        text: isLoading ?'Creating...':AppString.createaccount,
                        onPressd: isLoading
                         ? () {}
                      : createAccount,
                       ),
                      const SizedBox(height: 18),
                      RichText(text:  TextSpan(
                        text:AppString.alreadyhaveaccount,
                        style: AppTextStyle.regular14white,
                        children: [
                          TextSpan(
                              text:AppString.login,
                              style:AppTextStyle.regular14yellow,
                              recognizer: TapGestureRecognizer()
                                ..onTap =(){
                                  Navigator.of(context).pushNamed(AppRoutes.loginScreen);

                                }
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

