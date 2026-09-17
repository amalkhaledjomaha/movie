import 'package:moviesproject/features/home/data/model/movie_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Movie> movies;

  SearchSuccess(this.movies);
}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure(this.message);
}