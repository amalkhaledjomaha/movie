import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';

import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/widgets/rating_badge.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 260,

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [


          SizedBox(
            width: 200,
            height: 250,

            child: Stack(
              children: [

                Positioned.fill(
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(13),

                    child: Image.network(
                      movie.mediumCoverImage,

                      fit: BoxFit.cover,

                      errorBuilder:
                          (_, __, ___) {
                        return Container(
                          color:
                          AppColors.blackgray,

                          child:  Icon(
                            Icons.movie,
                            color: AppColors.white24,
                            size: 35,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: 7,
                  left: 7,

                  child: RatingBadge(
                    rating: movie.rating,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 7),

          // ==============================
          // TITLE
          // ==============================

          Text(
            movie.title,

            maxLines: 1,

            overflow:
            TextOverflow.ellipsis,

            style:  AppTextStyle.bold14white,
          ),

          const SizedBox(height: 3),


          Text(
            '${movie.year}',

            maxLines: 1,

            style: AppTextStyle.regular11white
          ),
        ],
      ),
    );
  }
}
