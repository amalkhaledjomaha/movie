import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/data/services/movie_service.dart';
import 'package:moviesproject/features/home/widgets/featured_card.dart';

import '../../../core/constants/app_string.dart';
import 'package:moviesproject/l10n/app_localizations.dart';


class BrowseTab extends StatefulWidget {
  final String? initialGenre;


  const BrowseTab({super.key,
    this.initialGenre
  });

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final MovieService _movieService = MovieService();

  final ScrollController _genreScrollController =
  ScrollController();

  final Map<String, GlobalKey> _genreKeys = {};
  List<Movie> _allMovies = [];

  List<String> _genres = [];

  List<Movie> _filteredMovies = [];

  String? _selectedGenre;

  bool _isLoading = true;

  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final movies = await _movieService.getMovies(
        limit: 50,
        sortBy: 'date_added',
      );

      final Set<String> genreSet = {};

      for (final movie in movies) {
        genreSet.addAll(movie.genres);
      }

      final genres = genreSet.toList();

      for (final genre in genres) {
        _genreKeys[genre] = GlobalKey();
      }
      setState(() {
        _allMovies = movies;
        _genres = genres;

        if (_genres.isNotEmpty) {
          if (widget.initialGenre != null &&
              _genres.contains(widget.initialGenre)) {
            _selectedGenre = widget.initialGenre;
          } else {
            _selectedGenre = _genres.first;
          }

          _filteredMovies = _allMovies.where((movie) {
            return movie.genres.contains(_selectedGenre);
          }).toList();
        }

        _isLoading = false;
      });

      if (_selectedGenre != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final key = _genreKeys[_selectedGenre];

          if (key?.currentContext != null) {
            Scrollable.ensureVisible(
              key!.currentContext!,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              alignment: 0.5,
            );
          }
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load movies';
      });
    }
  }

  void _selectGenre(String genre) {
    setState(() {
      _selectedGenre = genre;

      _filteredMovies = _allMovies.where((movie) {
        return movie.genres.contains(genre);
      }).toList();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final key = _genreKeys[genre];

      if (key?.currentContext != null) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          alignment: 0.5,
        );
      }
    });
  }  @override
  void didUpdateWidget(
      covariant BrowseTab oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialGenre != null) {
      _selectGenre(widget.initialGenre!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkblack,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              const SizedBox(height: 15),


              if (!_isLoading && _genres.isNotEmpty)

                SizedBox(
                  height: 55,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _genreScrollController,

                    itemCount: _genres.length,
                    itemBuilder: (context, index) {
                      final genre = _genres[index];


                      final bool isSelected =
                          _selectedGenre == genre;

                      return Padding(
                        key: _genreKeys[genre],

                        padding: const EdgeInsets.only(
                          right: 5,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _selectGenre(genre);
                          },

                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.yellow
                                  : Colors.transparent,

                              borderRadius:
                              BorderRadius.circular(16),

                              border: Border.all(
                                color: AppColors.yellow,
                                width: 1,
                              ),
                            ),

                            child: Text(
                              genre,

                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.black
                                    : AppColors.yellow,

                                fontSize: 20,

                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),




              const SizedBox(height: 8),


              Expanded(
                child: _buildMovies(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovies() {


    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.yellow,
        ),
      );
    }


    if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: const TextStyle(
            color: AppColors.white,
          ),
        ),
      );
    }


    if (_filteredMovies.isEmpty) {
      return const Center(
        child: Text(
          'No movies found',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
      );
    }


    return GridView.builder(
      padding: const EdgeInsets.only(
        bottom: 10,
        top: 4,
      ),

      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        crossAxisSpacing: 5,

        mainAxisSpacing: 5,

        childAspectRatio: 0.62,
      ),

      itemCount: _filteredMovies.length,

      itemBuilder: (context, index) {
        final movie = _filteredMovies[index];

        return FeaturedCard(
          movie: movie, isCenter: false,
        );
      },
    );
  }
}