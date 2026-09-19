import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';

class GenresSection extends StatelessWidget {
  final List<String> genres;
  final void Function(String genre) onGenreTap;

  const GenresSection({
    super.key,
    required this.genres,
    required this.onGenreTap,

  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: genres.map(
            (genre) {
          return SizedBox(
            width: 122,
            height: 36,
            child: GestureDetector(
              onTap: (){
                onGenreTap(genre);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.gray27,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  genre,
                  style: AppTextStyle.regular14white,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}