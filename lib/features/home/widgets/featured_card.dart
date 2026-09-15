import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/presentation/movie_details_page.dart';
import 'package:moviesproject/features/home/widgets/rating_badge.dart';
class FeaturedCard extends StatelessWidget {
  final Movie movie;
  final bool isCenter;

  const FeaturedCard({
    required this.movie,
    required this.isCenter,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(17),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return MovieDetailsPage(
                movieId: movie.id,
              );
            },
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        width: isCenter ? 200 : 165,
        height: isCenter ? 360 : 320,

        margin: const EdgeInsets.symmetric(
          horizontal: 4,
        ),

        child: Stack(
          children: [

            // Poster
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),

                child: Image.network(
                  movie.mediumCoverImage,

                  fit: BoxFit.cover,

                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: AppColors.gray27,

                      child:  Icon(
                        Icons.movie,
                        color: AppColors.white24,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Dark gradient
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),

                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [
                       AppColors.blackopacity15,
                        AppColors.transport,
                        AppColors.blackopacity25,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Rating
            Positioned(
              top: 8,
              left: 8,

              child: RatingBadge(
                rating: movie.rating,
              ),
            ),
          ],
        ),
      ),
    );
  }
}