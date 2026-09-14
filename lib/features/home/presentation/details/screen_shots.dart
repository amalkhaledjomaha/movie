import 'package:flutter/material.dart';

import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/app_text_style.dart';
class ScreenShots extends StatelessWidget {
  final List<String> screenshots;
  const ScreenShots({super.key,required this.screenshots,});

  @override
  Widget build(BuildContext context) {
    if (screenshots.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Center(
          child: Text(
            AppString.No_screenshots,
            style: AppTextStyle.bold14white,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: screenshots.map((imageUrl) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              height: 167,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}