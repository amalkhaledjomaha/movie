import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/l10n/app_localizations.dart';
import '../../../core/constants/app_string.dart';
class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColors.darkblack,
      body: SizedBox(
          child:Center(
            child:Text( AppLocalizations.of(context)!.search,style:TextStyle(color:Colors.red),) ,
          )
      ),
    );
  }
}