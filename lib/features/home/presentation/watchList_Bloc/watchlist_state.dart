part of 'watchlist_bloc.dart';

abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistSuccess extends WatchlistState {
  final List<MovieDetails> movies;

  WatchlistSuccess(this.movies);
}

class WatchlistFailure extends WatchlistState {
  final String message;

  WatchlistFailure(this.message);
}