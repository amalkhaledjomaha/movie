import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import 'package:moviesproject/core/constants/app_colors.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Container(
        width: double.infinity,
        color: AppColors.darkblack,
        child: Center(
          child: Image.asset(
            AppAssets.Empty,
            width: 180,
            height: 180,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}