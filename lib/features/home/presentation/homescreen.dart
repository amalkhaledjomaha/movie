import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/features/home/data/services/movie_service.dart';
import 'package:moviesproject/features/home/presentation/profile_Tab.dart';
import 'package:moviesproject/features/home/presentation/search_Tab.dart';
import 'package:moviesproject/features/home/presentation/browse_Tab.dart';
import 'package:moviesproject/features/home/presentation/homeTab.dart';
import 'package:moviesproject/features/home/presentation/watchList_Bloc/watchlist_bloc.dart';
import '../data/repository/watchlist_repository.dart';
import '../data/watchlist/watchlist_service.dart';
import '../domain/usecase/get_watchlist_usecase.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'package:moviesproject/features/home/presentation/homeTab.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/l10n/app_localizations.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;

  String? selectedBrowseGenre;

  int currentGenreIndex = 0;

  final MovieService _movieService = MovieService();

  List<String> genres = [];

  bool isLoadingGenres = true;
  // اسم النوع حسب اللغة
  String getGenreName(BuildContext context, String genre) {
    final localizations = AppLocalizations.of(context)!;

    switch (genre) {
      case 'action':
        return localizations.action;

      case 'romance':
        return localizations.romance;

      case 'comedy':
        return localizations.comedy;

      case 'horror':
        return localizations.horror;

      case 'thriller':
        return localizations.thriller;

      case 'sci-fi':
        return localizations.sciFi;

      default:
        return genre;
    }
  }
// دالة Browse
  void openBrowseWithGenre(String genre) {
    setState(() {
      selectedBrowseGenre = genre;
      selectedIndex = 2;
    });
  }

  //دالة gener
  Future<void> _loadGenres() async {
    try {
      final movies = await _movieService.getMovies(
        limit: 50,
        sortBy: 'rating',
      );

      final Set<String> genreSet = {};

      for (final movie in movies) {
        genreSet.addAll(movie.genres);
      }

      setState(() {
        genres = genreSet.toList();
        isLoadingGenres = false;
      });
    } catch (e) {
      setState(() {
        isLoadingGenres = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadGenres();
  }
  @override
  Widget build(BuildContext context) {

    if (isLoadingGenres || genres.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.darkblack,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.yellow,
          ),
        ),
      );
    }
    return BlocProvider(
        create: (_) => WatchlistBloc(
          GetWatchlistUseCase(
            WatchlistRepository(
              WatchlistService(),
            ),
          ),
        )..add(GetWatchlistEvent()),
        child: Scaffold(
      backgroundColor: AppColors.darkblack,

      body: IndexedStack(
        index: selectedIndex,
        children: [
          Hometab(
            genre: genres[currentGenreIndex],
            genreName: getGenreName(
              context,
              genres[currentGenreIndex],
            ),
            onGenreSelected: openBrowseWithGenre,

          ),

          const SearchTab(),
           BrowseTab(
            initialGenre: selectedBrowseGenre,

          ),
          const ProfileTab(),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          if (index == 0 && selectedIndex != 0) {
            setState(() {
              currentGenreIndex =
                  (currentGenreIndex + 1) % genres.length;

              selectedIndex = index;
            });

            return;
          }

          setState(() {
            selectedIndex = index;
          });

        },
      ),
    )
    );
  }
}