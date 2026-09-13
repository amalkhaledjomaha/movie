import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';

class DetailsSectionTitle extends StatelessWidget{

  final String title;

  const DetailsSectionTitle({
    required this.title,
  });

  @override
  Widget build(
      BuildContext context,
      ) {

    return Text(
        title,

        style:
        AppTextStyle.Bold24white

    );
  }
}