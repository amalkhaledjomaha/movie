import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/core/constants/app_colors.dart';

import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/features/auth/presentation/widgets/avatar_bottom_sheet.dart';


import 'package:moviesproject/features/auth/presentation/widgets/avatarcarousel.dart';

import 'package:moviesproject/features/auth/presentation/widgets/custom_button .dart';
import 'package:moviesproject/features/auth/presentation/widgets/customtextfield.dart';
import 'package:moviesproject/l10n/app_localizations.dart';

class UpdateProfileScreen extends StatefulWidget{
  const UpdateProfileScreen({super.key});
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

  class _UpdateProfileScreenState extends State<UpdateProfileScreen>{

  final FirebaseAuth _auth =FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  final TextEditingController nameController =TextEditingController();
  final TextEditingController phoneController =TextEditingController();

  String selectedAvatar = AppAssets.avaterone;
  bool isLoading =true;
  bool isUpdating =false;


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

    @override
    void initState()
    {
      super.initState();
      getUserData();
    }
    Future<void> getUserData() async{
      try{
        final User? user=_auth.currentUser;
        if(user ==null)
          {
            return;
          }
        final DocumentSnapshot userData =await _firestore.collection('users').doc(user.uid).get();
        if(userData.exists){
          final data=userData.data() as Map<String,dynamic>;
          nameController.text =data['name'] ?? '';
          phoneController.text =data['phone'] ?? '';

            if(data['avatar'] !=null &&data['avatar'].toString().isNotEmpty){
              selectedAvatar =data['avatar'];
            }
        }
      }
      catch(e){
        debugPrint('Error getting user data: $e');}
      finally
          {
            if(mounted){
              setState(() {
                isLoading =false;
              });
            }
          }
      }

      Future<void> updateUserData() async{
      if(!_formKey.currentState!.validate())
        {return;}
      final User ?user =_auth.currentUser;
      if(user ==null){
        return;
      }
      setState(() {
        isUpdating =true;
      });
      try{
        await _firestore.collection('users').doc(user.uid).update({
          'name' :nameController.text.trim(),
          'phone' :phoneController.text.trim(),
          'avatar' :selectedAvatar

        });
        await user.updateDisplayName(nameController.text.trim());
        if(!mounted) return;
        showDialog(
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
                    AppLocalizations.of(context)!.accountupdated,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.regular20whitewithoutalpha,
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.ok,
                      style: AppTextStyle.regular16yellow,
                    ),
                  ),
                ],
              ),
            );
          },
        );

      }catch (e)
        {
          if(!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.updateerror),
        ),
        );
        }finally{
        if(mounted){
          setState(() {
            isUpdating =false;
          });
        }
        }
      }
      Future<void>deleteAccount() async{
      final User? user =FirebaseAuth.instance.currentUser;
      if(user ==null){
        return;
      }
      final bool ?confirmDelete =await showDialog<bool>(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: AppColors.darkblack,
            title: Text(AppLocalizations.of(context)!.deleteaccounttitle,style: AppTextStyle.regular20whitewithoutalpha,),
            content:
             Text(
               AppLocalizations.of(context)!.deleteaccountmessage,
              style: AppTextStyle.regular16white,
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context, false);
                },
                child: Text(AppLocalizations.of(context)!.cancel,style: AppTextStyle.regular16white,
                ),
              ),
          TextButton(onPressed: (){
            Navigator.pop(context, true);

          }, child: Text(AppLocalizations.of(context)!.delete,style: AppTextStyle.regular16red,
          ),)
            ],


          );
        }
      );
      if(confirmDelete != true)
        {
          return;
        }
      try{
        setState(() {
          isLoading =true;
        });
        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();
        await user.delete();
        if(!mounted) return;
        Navigator.pushNamedAndRemoveUntil(context,
            AppRoutes.loginScreen, (route)=>false,);

      }on FirebaseAuthException catch(e){
        if(!mounted) return;
        setState(() {
          isLoading =false;
        });
        if(e.code =='requires-recent-login'){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('For security, please login again before deleting your account.',
            ),
            ),
          );
        }else
          {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content:
               Text( e.message ?? 'Failed to delete account',

              ),
              ),
            );
          }
      }catch(e)
        {
          if(!mounted) return;
          setState(() {
            isLoading =false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:
            Text( 'Error deleting account: $e',
            ),
            ),
          );

        }
      }



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
    void dispose(){
      nameController.dispose();
      phoneController.dispose();
      super.dispose();
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
        title:Text( AppLocalizations.of(context)!.pickavatar,
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
                child: Form(
                  key: _formKey,
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
                      CustomTextField(
                          controller :nameController,
                          hintText: '',
                          prefixIcon: AppAssets.User,
                      validator: (value){
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(context)!.nameisrequired;
                        }
                        if (value.trim().length < 3) {
                          return AppLocalizations.of(context)!.namemustbeatleast3characters; }
                        return null;
                      },),

                       SizedBox(height: 16),
                      //email
                      CustomTextField(
                          controller:phoneController,
                          hintText: '',
                          prefixIcon: AppAssets.phone,
                      validator:(value) {
                if (value == null || value.trim().isEmpty) {
                return AppLocalizations.of(context)!.phoneisrequired;
                }
                if (value.length < 10) {
                return AppLocalizations.of(context)!.phonethan10;
                }
                if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
                  return AppLocalizations.of(context)!.invalidphone;
                }
                return null;
                },),
                       SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                        style: TextButton.styleFrom(overlayColor: Colors.transparent),onPressed: (){
                          Navigator.pushNamed(context, AppRoutes.resetPasswordScreen,);
                        },
                          child: Text(AppLocalizations.of(context)!.resetpassword,style: AppTextStyle.regular20whitewithoutalpha,),),
                      ),
                      Spacer(),
                      CustomButton(text: AppLocalizations.of(context)!.deleteaccount, onPressd:deleteAccount,backgroundColor :AppColors.red),
                       SizedBox(height: 16),
                      CustomButton(text:isUpdating ?'Updating...'
                          : AppLocalizations.of(context)!.updatedata, onPressd: isUpdating ?(){}
                      :updateUserData,),


                    ],

                  ),
                ),
              ),
            );

          },
        ),),
    );

  }

}