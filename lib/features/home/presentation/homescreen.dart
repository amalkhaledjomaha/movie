import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/core/routes/app_routes.dart';
import 'package:moviesproject/features/home/presentation/profile_Tab.dart';
import 'package:moviesproject/features/home/presentation/search_Tab.dart';
import 'package:moviesproject/features/home/presentation/browse_Tab.dart';
import 'package:moviesproject/features/home/presentation/homeTab.dart';
import 'package:moviesproject/features/home/presentation/search_bloc/search_bloc.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'package:moviesproject/features/home/presentation/homeTab.dart';
import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesproject/features/home/data/services/movie_service.dart';
import 'package:moviesproject/features/home/data/repositories/movie_repository.dart';
import 'package:moviesproject/features/home/domain/search_movie_usecase.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int selectedIndex = 0;
  int currentGenreIndex = 0;

  final List<String> genres = [
    'action',
    'romance',
    'comedy',
    'horror',
    'thriller',
    'sci-fi',
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),

        BlocProvider(
          create: (_) => SearchBloc(
            searchMovieUseCase: SearchMovieUseCase(
              movieRepository: MovieRepository(
                movieService: MovieService(),
              ),
            ),
          ),
          child: const SearchTab(),
        ),
          const BrowseTab(),
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
    );
  }
}