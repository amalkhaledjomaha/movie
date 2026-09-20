import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/data/services/movie_service.dart';

class MovieRepository {
  final MovieService movieService;

  MovieRepository({
    required this.movieService,
  });

  Future<List<Movie>> searchMovies(String query) {
    return movieService.getMovies(
      queryTerm: query,
    );
  }
}