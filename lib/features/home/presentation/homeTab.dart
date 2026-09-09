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
import 'package:moviesproject/l10n/app_localizations.dart';

class Hometab extends StatefulWidget  {
  final String genre;
  final String genreName;

  const Hometab({
    super.key,
    required this.genre,
    required this.genreName,

  });


  @override
  State<Hometab> createState() => HometabState();
}

class HometabState extends State<Hometab> {
  final MovieService _movieService = MovieService();

  late Future<List<Movie>> _moviesFuture;
  late Future<List<Movie>> _genreMoviesFuture;

  int _currentMovie = 0;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  void didUpdateWidget(covariant Hometab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.genre != widget.genre) {
      _loadGenreMovies();
    }
  }

  void _loadMovies() {
    _moviesFuture = _movieService.getMovies(
      limit: 10,
      sortBy: 'date_added',
    );

    _loadGenreMovies();
  }

  void _loadGenreMovies() {
    _genreMoviesFuture = _movieService.getMovies(
      genre: widget.genre,
      limit: 20,
      sortBy: 'date_added',
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _loadMovies();
    });

    await Future.wait([
      _moviesFuture,
      _genreMoviesFuture,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

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

                const SizedBox(height: 40),


                Center(
                  child: Text(
                    localizations.watchnow,
                    style: AppTextStyle.pacifio57white,
                  ),
                ),

                const SizedBox(height: 15),



                FutureBuilder<List<Movie>>(
                  future: _genreMoviesFuture,

                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SectionLoading(
                        title: widget.genreName,
                      );
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return MovieSection(
                      title: widget.genreName,

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