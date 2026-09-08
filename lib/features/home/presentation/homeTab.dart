import 'package:flutter/material.dart';

import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/data/services/movie_service.dart';

import 'package:moviesproject/features/home/widgets/featured_movies.dart';
import 'package:moviesproject/features/home/widgets/movie_section.dart';
import 'package:moviesproject/features/home/widgets/featured_loading.dart';
import 'package:moviesproject/features/home/widgets/section_loading.dart';
import 'package:google_fonts/google_fonts.dart';

class Hometab extends StatefulWidget  {
  const Hometab({super.key});


  @override
  State<Hometab> createState() => _HometabState();
}

class _HometabState extends State<Hometab> {
  final MovieService _movieService = MovieService();

  late Future<List<Movie>> _moviesFuture;
  late Future<List<Movie>> _actionMoviesFuture;

  int _currentMovie = 0;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _loadMovies() {
    _moviesFuture = _movieService.getMovies(
      limit: 10,
      sortBy: 'rating',
    );

    _actionMoviesFuture = _movieService.getMovies(
      genre: 'action',
      limit: 20,
      sortBy: 'rating',
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _loadMovies();
    });

    await Future.wait([
      _moviesFuture,
      _actionMoviesFuture,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blacklight,

      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.yellow,
          backgroundColor: AppColors.blackgray,
          onRefresh: _refresh,

          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

            child: Column(
              children: [
                const SizedBox(height: 5),

                FutureBuilder<List<Movie>>(
                  future: _moviesFuture,

                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const FeaturedLoading();
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return FeaturedMovies(
                      movies: snapshot.data!,
                      currentIndex: _currentMovie,

                      onChanged: (index) {
                        setState(() {
                          _currentMovie = index;
                        });
                      },
                    );
                  },
                ),

                 SizedBox(height: 40),

                 Center(
                  child: Text(
                    AppString.watchnow,
                    style:AppTextStyle.pacifio57white,
                  ),

                ),

                const SizedBox(height: 15),

                FutureBuilder<List<Movie>>(
                  future: _actionMoviesFuture,

                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return  SectionLoading(
                        title:AppString.action ,
                      );
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return MovieSection(
                      title: AppString.action,
                      movies: snapshot.data!,
                    );
                  },
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
