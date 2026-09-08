import 'package:flutter/material.dart';
import 'package:moviesproject/core/constants/app_string.dart';
import 'package:moviesproject/core/constants/app_text_style.dart';
import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/widgets/movie_card.dart';
import 'package:moviesproject/features/home/widgets/rating_badge.dart';
class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MovieSection({
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            children: [

              Text(
                title,
                style: AppTextStyle.regular20whitewithoutalpha,
              ),

              const Spacer(),

              TextButton(
                onPressed: () {},

                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                ),

                child:  Text(
                 AppString.seemore,
                  style: AppTextStyle.regular14yellow,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 350,

          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            scrollDirection: Axis.horizontal,

            itemCount:
            movies.length > 10
                ? 10
                : movies.length,

            separatorBuilder: (_, __) {
              return const SizedBox(width: 12);
            },

            itemBuilder: (context, index) {
              return MovieCard(
                movie: movies[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
