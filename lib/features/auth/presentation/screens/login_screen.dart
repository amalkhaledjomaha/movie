import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/features/auth/presentation/widgets/custom_button .dart';
import 'package:moviesproject/features/auth/presentation/widgets/customtextfield.dart';
import 'package:moviesproject/features/auth/presentation/widgets/flag/egypt_flag.dart';
import 'package:moviesproject/features/auth/presentation/widgets/flag/liberia_flag.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  bool isFlafSelected = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkblack,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            final horizontalPadding = screenWidth < 400 ? 16.0 : 24.0;
            final contentWidth = screenWidth > 500
                ? 420.0
                : screenWidth - (horizontalPadding * 2);
            final logoSize = (screenWidth * 0.30).clamp(90.0, 121.0);
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: screenHeight < 700 ? 30 : 55,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentWidth),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: logoSize,
                        width: logoSize,
                        child: Image.asset(
                          AppAssets.Login,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: screenHeight < 700 ? 30 : 45),
                      CustomTextField(
                        hintText: AppString.email,
                        prefixIcon: AppAssets.Email,
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppString.emailisrequired;
                          }
                          if (!value.contains('@')) {
                            return AppString.enteravalidemail;
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintText: AppString.password,
                        prefixIcon: AppAssets.Password,
                        obscureText: !isPasswordVisible,
                        suffIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.white,
                          ),
                        ),
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.passwordisrequired;
                          }

                          if (value.length < 6) {
                            return AppString.passwordmustbeatleast6characters;
                          }

                          return null;
                        },
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.resetPasswordScreen,
                            );
                          },
                          child: Text(
                            AppString.forgetenpaword,
                            style: AppTextStyle.regular14yellow,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      CustomButton(
                        text: AppString.login,
                        onPressd: () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                );

                            if (!mounted) return;

                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.homescreen,
                            );
                          } on FirebaseAuthException catch (e) {
                            String message;

                            switch (e.code) {
                              case AppString.invalid_credential :
                                message = AppString.emailorpasswordisincorrect;
                                break;

                              case  AppString.user_not_found:
                                message =AppString.noaccountfoundwiththisemail;
                                break;

                              case AppString.wrong_password :
                                message =AppString.incorrectPassword;
                                break;

                              case AppString.invalid_email:
                                message =AppString.pleaseenteravalidemail;
                                break;
                              case AppString.too_many_requests :
                                message =AppString.too_many_attempts ;
                              default:
                                message =
                                    AppString. something_went_wrong;
                            }

                            if (!mounted) return;

                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.scale,
                              dialogBackgroundColor: AppColors.darkblack,
                              title: AppString.login_title,
                              titleTextStyle: AppTextStyle.Bold24white,
                              desc: message,
                              descTextStyle: AppTextStyle.regular16white,
                              btnOkText: AppString.ok,
                              btnOkColor: AppColors.yellow,
                              btnOkOnPress: () {},
                            ).show();
                          }
                        },
                      ),

                      const SizedBox(height: 18),
                      RichText(
                        text: TextSpan(
                          text: AppString.donthaveaccount,
                          style: AppTextStyle.regular14white,
                          children: [
                            TextSpan(
                              text: AppString.createone,
                              style: AppTextStyle.regular14yellow,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.registerScreen,
                                  );
                                },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 92),
                              child: Divider(
                                color: AppColors.yellow,
                                thickness: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              AppString.or,
                              style: AppTextStyle.regular14yellow,
                            ),
                          ),
                          Flexible(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 92),
                              child: Divider(
                                color: AppColors.yellow,
                                thickness: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.yellow,
                            foregroundColor: AppColors.darkblack,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('G', style: AppTextStyle.Bold24black),
                              const SizedBox(width: 12),
                              Text(
                                AppString.loginwithgoogle,
                                style: AppTextStyle.regular16black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFlafSelected = !isFlafSelected;
                          });
                        },
                        child: Container(
                          width: 90.72,
                          height: 38.08,
                          decoration: BoxDecoration(
                            color: AppColors.darkblack,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: AppColors.yellow,
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 200),
                                left: isFlafSelected ? -2 : null,
                                right: isFlafSelected ? null : -2,
                                top: -2,
                                child: Container(
                                  width: 40.08,
                                  height: 38.08,
                                  decoration: BoxDecoration(
                                    color: AppColors.yellow,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 200),

                                left: isFlafSelected ? 1 : 7,
                                top: isFlafSelected ? 1 : 7,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFlafSelected = true;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: isFlafSelected ? 34 : 26,
                                    height: isFlafSelected ? 34 : 26,
                                    child: const LiberiaFlag(),
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 200),

                                right: isFlafSelected ? 7 : 1,
                                top: isFlafSelected ? 7 : 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFlafSelected = true;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: isFlafSelected ? 26 : 34,
                                    height: isFlafSelected ? 26 : 34,
                                    child: const EgyptFlag(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
        ),
      ),
    );
  }
}
