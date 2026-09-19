import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/features/home/presentation/movie_details_page.dart';
import 'package:moviesproject/features/home/presentation/watchList_Bloc/watchlist_bloc.dart';


class WatchListPage extends StatelessWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Container(
        width: double.infinity,
        color: AppColors.darkblack,
        child:const _WatchListContent(),
      ),
    );
  }
}

class _WatchListContent extends StatelessWidget {
  const _WatchListContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state is WatchlistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is WatchlistFailure) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                color: AppColors.white,
              ),
            ),
          );
        }

        if (state is WatchlistSuccess) {
          if (state.movies.isEmpty) {
            return Center(
              child: Image.asset(
                AppAssets.Empty,
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movie = state.movies[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(
                        movieId: movie.id,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          movie.mediumCoverImage,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.darkblack
                                .withValues(alpha: 0.71),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                movie.rating.toString(),
                                style: const TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(width: 3),
                              const Icon(
                                Icons.star,
                                color: AppColors.yellow,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}