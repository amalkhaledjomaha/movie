import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';

import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/widgets/featured_card.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesproject/l10n/app_localizations.dart';

class FeaturedMovies extends StatefulWidget {
  final List<Movie> movies;
  final int currentIndex;
  final Function(int) onChanged;

  const FeaturedMovies({
    super.key,
    required this.movies,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  State<FeaturedMovies> createState() => _FeaturedMoviesState();
}
class _FeaturedMoviesState extends State<FeaturedMovies> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      viewportFraction: 0.40,
      initialPage: widget.currentIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Movie currentMovie =
    widget.movies[widget.currentIndex];

    return SizedBox(
      height: 450,

      child: Stack(
        children: [

          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),

              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },

              child: Stack(
                key: ValueKey(currentMovie.id),

                fit: StackFit.expand,

                children: [

                  Image.network(
                    currentMovie.mediumCoverImage,

                    fit: BoxFit.cover,

                    errorBuilder: (_, __, ___) {
                      return Container(
                        color:AppColors.black,
                      );
                    },
                  ),

                  // Dark overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,

                        colors: [
                          AppColors.black.withOpacity(0.30),
                          AppColors.black.withOpacity(0.45),
                          const Color(0xFF080909)
                              .withOpacity(0.98),
                        ],

                        stops: const [
                          0.0,
                          0.55,
                          1.0,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 40,
            left: 0,
            right: 0,


            child: Center(
              child: Text(
                AppLocalizations.of(context)!.availablenow,
                style: AppTextStyle.pacifio45white,
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            bottom: 40,
            child: PageView.builder(
              controller: _controller,

              itemCount: widget.movies.length,

              onPageChanged: (index) {
                widget.onChanged(index);
              },

              itemBuilder: (context, index) {
                final movie = widget.movies[index];

                return AnimatedBuilder(
                  animation: _controller,

                  builder: (context, child) {
                    double scale = 1.0;

                    if (_controller.position.haveDimensions) {
                      final page = _controller.page ??
                          _controller.initialPage.toDouble();

                      final difference =
                      (page - index).abs();

                      scale = (1 - difference * 0.12)
                          .clamp(0.82, 1.0);
                    }

                    return Center(
                      child: Transform.scale(
                        scale: scale,

                        child: FeaturedCard(
                          movie: movie,

                          isCenter:
                          index == widget.currentIndex,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
