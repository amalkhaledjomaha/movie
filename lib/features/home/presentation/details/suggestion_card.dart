import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/presentation/movie_details_page.dart';

class SuggestionCard extends StatelessWidget {

  final Movie movie;

  const SuggestionCard({
    required this.movie,
  });

  @override
  Widget build(
      BuildContext context,
      ) {

    return GestureDetector(
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

      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(8),

        child: Stack(
          children: [

            // ==========================================
            // POSTER
            // ==========================================

            Positioned.fill(
              child: Image.network(
                movie.mediumCoverImage,

                fit: BoxFit.cover,

                errorBuilder:
                    (_, __, ___) {

                  return Container(
                    color:
                    AppColors.blackgray,

                    child: const Icon(
                      Icons.movie,
                      color:
                      AppColors.white24,
                    ),
                  );
                },
              ),
            ),

            Positioned(
              top: 5,
              left: 5,

              child: Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 2,
                ),

                decoration:
                BoxDecoration(
                  color:
                  Colors.black.withOpacity(
                    0.7,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                    5,
                  ),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.star,
                      color:
                      AppColors.gold,
                      size: 9,
                    ),

                    const SizedBox(
                      width: 2,
                    ),

                    Text(
                      movie.rating
                          .toString(),

                      style:
                      const TextStyle(
                        color: AppColors.white,
                        fontSize: 7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
