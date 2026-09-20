import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moviesproject/core/constants/app_colors.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesproject/features/home/presentation/search_bloc/search_bloc.dart';
import 'package:moviesproject/features/home/presentation/search_bloc/search_event.dart';
import 'package:moviesproject/features/home/presentation/search_bloc/search_state.dart';
import 'package:moviesproject/l10n/app_localizations.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_string.dart';
import 'movie_details_page.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:AppColors.darkblack,
      body: SafeArea(
        child:Column(
          children: [
            const SizedBox(height: 16),
            //searsh filed
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                style: const TextStyle(
                  color: AppColors.white,
                ),
                onChanged: (value) {
                  if (value.trim().isNotEmpty) {
                    setState(() {
                      isSearching = true;
                    });

                    BlocProvider.of<SearchBloc>(context).add(
                      SearchMovieEvent(value),
                    );
                  } else {
                    setState(() {
                      isSearching = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText:AppString.search,
                  hintStyle: AppTextStyle.regular16white,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 8,
                    ),
                    child:SvgPicture.asset(
                      AppAssets.search,
                      width: 16,
                      height: 16,
                      color: AppColors.white,
                    ),
                  ),
                  filled: true,
                  fillColor:AppColors.searchbackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // search card
            Expanded(
              child: !isSearching
                  ? Center(
                child: Image.asset(
                  AppAssets.emptylist,
                ),
              )
                  : BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is SearchFailure) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    );
                  }

                  if (state is SearchSuccess) {
                    if (state.movies.isEmpty) {
                      return Center(
                        child: Image.asset(
                          AppAssets.emptylist,
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
