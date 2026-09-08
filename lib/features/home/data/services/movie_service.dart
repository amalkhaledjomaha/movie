import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviesproject/features/home/data/model/movie_model.dart';


class MovieService {
  static const String _baseUrl =
      'https://yts.gg/api/v2/list_movies.json';

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
}