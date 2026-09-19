import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_assets.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/features/home/data/services/history_service.dart';
import 'package:moviesproject/features/home/data/services/movie_service.dart';
import 'package:moviesproject/features/home/presentation/movie_details_page.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({
    super.key,
  });





  final HistoryService _historyService = HistoryService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkblack,
      width: double.infinity,


      child: StreamBuilder(
        stream: _historyService.getHistory(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.yellow,
              ),
            );
          }

          if (snapshot.hasError) {
            return  Center(
              child: Text(
                AppString.something_went_wrong,
                style: AppTextStyle.regular11white
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.75,
              ),
              child: ConstrainedBox(
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
              ),
            );
          }

          final history = snapshot.data!.docs;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),

            itemCount: history.length,

            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
              childAspectRatio: 0.55,
            ),

            itemBuilder: (context, index) {

              final historyData = history[index].data();

              final int movieId = historyData['movieId'];

              return FutureBuilder(
                future: MovieService().getMovieDetails(movieId),

                builder: (context, movieSnapshot) {

                  if (movieSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.yellow,
                        ),
                      ),
                    );
                  }

                  if (movieSnapshot.hasError ||
                      !movieSnapshot.hasData) {
                    return const SizedBox();
                  }

                  final movie = movieSnapshot.data!;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailsPage(
                                movieId: movie.id,
                              ),
                        ),
                      );
                    },

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),

                      child: Image.network(
                        movie.mediumCoverImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}