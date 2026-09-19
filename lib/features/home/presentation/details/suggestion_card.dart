import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/data/services/history_service.dart';
import 'package:moviesproject/features/home/presentation/movie_details_page.dart';

class SuggestionCard extends StatelessWidget {

  final Movie movie;
  final void Function(String genre)? onGenreSelected;

  const SuggestionCard({
    required this.movie,
    this.onGenreSelected,

  });

  @override
  Widget build(
      BuildContext context,
      ) {
    final HistoryService _historyService = HistoryService();
    return GestureDetector(
      onTap: () async {
        await _historyService.addToHistory(movie.id);

        if (!context.mounted) return;

        final selectedGenre = await Navigator.push<String>(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailsPage(
              movieId: movie.id,
              onGenreSelected: onGenreSelected,
            ),
          ),
        );

        // 3. استقبال الـ Genre المختار
        if (selectedGenre != null) {
          onGenreSelected?.call(selectedGenre);
        }
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

                    Text(
                      movie.rating
                          .toString(),

                      style:
                      const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),

                    const Icon(
                      Icons.star,
                      color:
                      AppColors.gold,
                      size: 20,
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
