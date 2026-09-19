import 'package:moviesproject/features/home/data/model/movie_details.dart';
import '../../data/repository/watchlist_repository.dart';


class GetWatchlistUseCase {
  final WatchlistRepository _repository;

  GetWatchlistUseCase(this._repository);

  Stream<List<MovieDetails>> call() {
    return _repository.watchlistStream();
  }
}