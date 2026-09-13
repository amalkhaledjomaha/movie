import 'package:flutter/material.dart';

import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/features/home/data/model/movie_details.dart';

import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/data/services/movie_service.dart';
import 'package:moviesproject/features/home/presentation/details/cast_section.dart';
import 'package:moviesproject/features/home/presentation/details/details_section_title.dart';
import 'package:moviesproject/features/home/presentation/details/genres_section.dart';
import 'package:moviesproject/features/home/presentation/details/suggestion_grid.dart';


class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  const MovieDetailsPage({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailsPage> createState() =>
      _MovieDetailsPageState();
}


class _MovieDetailsPageState extends State<MovieDetailsPage> {

  final MovieService _movieService =
  MovieService();

  late Future<MovieDetails> _detailsFuture;

  late Future<List<Movie>> _suggestionsFuture;


  @override
  void initState() {
    super.initState();

    _detailsFuture =
        _movieService.getMovieDetails(
          widget.movieId,
        );

    _suggestionsFuture =
        _movieService.getMovieSuggestions(
          widget.movieId,
        );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      AppColors.blacklight,

      body: SafeArea(
        child: FutureBuilder<MovieDetails>(
          future: _detailsFuture,

          builder: (context,
              snapshot,) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellow,
                ),
              );
            }


            if (snapshot.hasError ||
                !snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,

                  children: [

                    Icon(
                      Icons.error_outline,
                      color: AppColors.white24,
                      size: 45,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      AppString.failedtoloadmovie,
                      style:
                      AppTextStyle.bold14white,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _detailsFuture =
                              _movieService
                                  .getMovieDetails(
                                widget.movieId,
                              );
                        });
                      },

                      child: Text(
                        AppString.retry,
                      ),
                    ),
                  ],
                ),
              );
            }


            final movie =
            snapshot.data!;

            return _buildDetails(
              movie,
            );
          },
        ),
      ),
    );
  }



  Widget _buildDetails(MovieDetails movie,) {
    return SingleChildScrollView(
      physics:
      const AlwaysScrollableScrollPhysics(),

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [


          Align(
            alignment:
            Alignment.centerLeft,

            child: IconButton(
              padding: EdgeInsets.zero,

              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
                size: 18,
              ),

              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),


          SuggestionGrid(suggestionsFuture: _suggestionsFuture,),


          const SizedBox(
            height: 14,
          ),


          const DetailsSectionTitle(
            title: AppString.summary,
          ),

          const SizedBox(
            height: 5,
          ),

          Text(
              movie.description.isNotEmpty
                  ? movie.description
                  : AppString.nodescriptionavailable,

              style:
              AppTextStyle.regular14white
          ),


          const SizedBox(
            height: 12,
          ),


          // CAST


          DetailsSectionTitle(
            title: AppString.cast,
          ),

          const SizedBox(
            height: 6,
          ),

          CastSection(
            cast: movie.cast,
          ),


          const SizedBox(
            height: 12,
          ),


          DetailsSectionTitle(
            title: AppString.genres,
          ),

          const SizedBox(
            height: 6,
          ),

          GenresSection(
            genres: movie.genres,
          ),


          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

}


