import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';

import '../../../core/constants/app_text_style.dart';

class SectionLoading extends StatelessWidget {
  final String title;

  const SectionLoading({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Padding(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 20,
          ),

          child: Text(
            title,

            style: AppTextStyle.bold18white,
          ),
        ),

        const SizedBox(height: 15),

         SizedBox(
          height: 150,

          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.gold,
            ),
          ),
        ),
      ],
    );
  }
}
