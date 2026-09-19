part of 'watchlist_bloc.dart';

abstract class WatchlistEvent {}

class GetWatchlistEvent extends WatchlistEvent {}

class WatchlistUpdatedEvent extends WatchlistEvent {
  final List<MovieDetails> movies;

  WatchlistUpdatedEvent(this.movies);
}

class WatchlistErrorEvent extends WatchlistEvent {
  final String message;

  WatchlistErrorEvent(this.message);

}

