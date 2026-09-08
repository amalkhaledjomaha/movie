import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        currentIndex: currentIndex,
        onTap: onTap,

        type: BottomNavigationBarType.fixed,

        showSelectedLabels: false,
        showUnselectedLabels: false,

        items:  [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.home,
              width: 26,
              height: 23,
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? AppColors.yellow : AppColors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.search,
              width: 26,
              height: 23,
              colorFilter: ColorFilter.mode(
                currentIndex == 1 ? AppColors.yellow : AppColors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.browse,
              width: 26,
              height: 23,
              colorFilter: ColorFilter.mode(
                currentIndex == 2 ? AppColors.yellow : AppColors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.Profiel,
              width: 26,
              height: 23,
              colorFilter: ColorFilter.mode(
                currentIndex == 3 ? AppColors.yellow : AppColors.white,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
