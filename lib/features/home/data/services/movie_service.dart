import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:moviesproject/features/home/data/model/movie_details.dart';
import 'package:moviesproject/features/home/data/model/movie_model.dart';


class MovieService {
  static const String _baseUrl =
      'https://yts.gg/api/v2/list_movies.json';
  static const String _detailsUrl =
      'https://yts.gg/api/v2/movie_details.json';

  static const String _suggestionsUrl =
      'https://yts.gg/api/v2/movie_suggestions.json';

  Future<List<Movie>> getMovies({
    String? genre,
    int limit = 20,
    String sortBy = 'date_added',
  }) async {
    final queryParameters = {
      'limit': limit.toString(),
      'sort_by': sortBy,
      'order_by': 'desc',
    };

    if (genre != null) {
      queryParameters['genre'] = genre;
    }

    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: queryParameters,
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load movies');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    final List moviesJson = data['data']?['movies'] ?? [];

    return moviesJson
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }

  //detail
  Future<MovieDetails> getMovieDetails(
      int movieId,
      ) async {

    final uri = Uri.parse(
      _detailsUrl,
    ).replace(
      queryParameters: {
        'movie_id': movieId.toString(),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load movie details',
      );
    }

    final Map<String, dynamic> data =
    jsonDecode(response.body);

    final movieJson =
    data['data']?['movie'];

    if (movieJson == null) {
      throw Exception(
        'Movie details not found',
      );
    }
    print('MOVIE KEYS: ${movieJson.keys}');
    print('CAST: ${movieJson['cast']}');
    return MovieDetails.fromJson(
      movieJson,
    );
  }


  //  SUGGESTIONS

  Future<List<Movie>> getMovieSuggestions(
      int movieId,
      ) async {

    final uri = Uri.parse(
      _suggestionsUrl,
    ).replace(
      queryParameters: {
        'movie_id': movieId.toString(),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load movie suggestions',
      );
    }

    final Map<String, dynamic> data =
    jsonDecode(response.body);

    final List moviesJson =
        data['data']?['movies'] ?? [];

    return moviesJson
        .map(
          (movie) => Movie.fromJson(
        movie,
      ),
    )
        .toList();
  }
}