import 'package:moviesproject/features/home/data/model/movie_details.dart';
import '../watchlist/watchlist_service.dart';

class WatchlistRepository {
  final WatchlistService _service;

  WatchlistRepository(this._service);

  Stream<List<MovieDetails>> watchlistStream() {
    return _service.watchlistStream();
  }
}