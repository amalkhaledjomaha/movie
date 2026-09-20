import 'package:moviesproject/features/home/data/model/movie_model.dart';
import 'package:moviesproject/features/home/data/repository/movie_repository.dart';

class SearchMovieUseCase {
  final MovieRepository movieRepository;

  SearchMovieUseCase({
    required this.movieRepository,
  });

  Future<List<Movie>> call(String query) {
    return movieRepository.searchMovies(query);
  }
}