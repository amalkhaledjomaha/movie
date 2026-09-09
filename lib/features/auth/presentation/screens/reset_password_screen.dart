import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:moviesproject/l10n/app_localizations.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkblack,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);

          },
          icon: Icon(Icons.arrow_back),
          color: AppColors.yellow,
        ),
        title: Text(
          AppLocalizations.of(context)!.forgetPassword,
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
              Form(
                key:formKey ,
                child:Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller:emailController,
                  style: AppTextStyle.regular16white,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.emailisrequired;
                    }

                    if (!value.contains('@')) {
                      return AppLocalizations.of(context)!.enteravalidemail;
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.black,
                    hint: Text(
                      AppLocalizations.of(context)!.email,
                      style: AppTextStyle.regular16white,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        AppAssets.Email,
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                  ),

                ),
              )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right:16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailController.text.trim(),
                      );

                      if (!mounted) return;

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.scale,
                        dialogBackgroundColor: AppColors.darkblack,
                        title: AppLocalizations.of(context)!.title_success,
                        titleTextStyle: AppTextStyle.Bold24white,
                        desc: AppLocalizations.of(context)!.desc_Success,
                        descTextStyle: AppTextStyle.regular16white,
                        btnOkText:AppLocalizations.of(context)!.ok,
                        btnOkColor: AppColors.yellow,
                        btnOkOnPress: () {
                          Navigator.pop(context);
                        },
                      ).show();

                    } on FirebaseAuthException catch (e) {

                      String message;

                      switch (e.code) {
                        case AppString.invalid_email:
                          message =AppLocalizations.of(context)!.pleaseenteravalidemail;
                          break;

                        case AppString.user_not_found:
                          message =  AppLocalizations.of(context)!.noaccountfoundwiththisemail;
                          break;

                        case  AppString.too_many_requests:
                          message =AppLocalizations.of(context)!.too_many_attempts;
                          break;

                        default:
                          message =AppLocalizations.of(context)!.something_went_wrong;
                      }

                      if (!mounted) return;

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.scale,
                        dialogBackgroundColor: AppColors.darkblack,
                        title:AppLocalizations.of(context)!.title_error,
                        titleTextStyle: AppTextStyle.Bold24white,
                        desc: message,
                        descTextStyle: AppTextStyle.regular16white,
                        btnOkText:AppLocalizations.of(context)!.ok,
                        btnOkColor: AppColors.yellow,
                        btnOkOnPress: () {},
                      ).show();
                    }
                  },
                  style:ElevatedButton.styleFrom(
                    backgroundColor:AppColors.yellow,
                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  child: Text(AppLocalizations.of(context)!.verifyEmail,style:AppTextStyle.regular20black,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
