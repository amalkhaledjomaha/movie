import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'suggestion_card.dart';

class SuggestionGrid extends StatelessWidget {
  final Future<List<Movie>> suggestionsFuture;

  const SuggestionGrid({
    super.key,
    required this.suggestionsFuture,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: suggestionsFuture,
      builder: (
          context,
          snapshot,
          ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 220,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.yellow,
              ),
            ),
          );
        }

        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final movies = snapshot.data!;

        final displayedMovies = movies.take(4).toList();

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayedMovies.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7,
            childAspectRatio: 0.67,
          ),
          itemBuilder: (
              context,
              index,
              ) {
            final movie = displayedMovies[index];

            return SuggestionCard(
              movie: movie,
            );
          },
        );
      },
    );
  }
}