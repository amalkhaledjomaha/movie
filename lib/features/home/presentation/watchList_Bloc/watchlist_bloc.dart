import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesproject/features/home/data/model/movie_details.dart';

import '../../domain/usecase/get_watchlist_usecase.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistUseCase _getWatchlistUseCase;

  StreamSubscription<List<MovieDetails>>? _watchlistSubscription;

  WatchlistBloc(this._getWatchlistUseCase)
      : super(WatchlistInitial()) {
    on<GetWatchlistEvent>(_getWatchlist);
    on<WatchlistUpdatedEvent>(_watchlistUpdated);
    on<WatchlistErrorEvent>(_watchlistError);
  }

  Future<void> _getWatchlist(
      GetWatchlistEvent event,
      Emitter<WatchlistState> emit,
      ) async {
    emit(WatchlistLoading());

    await _watchlistSubscription?.cancel();

    _watchlistSubscription = _getWatchlistUseCase().listen(
          (movies) {
        add(
          WatchlistUpdatedEvent(movies),
        );
      },
      onError: (error) {
        add(
          WatchlistErrorEvent(error.toString()),
        );
      },
    );
  }

  void _watchlistUpdated(
      WatchlistUpdatedEvent event,
      Emitter<WatchlistState> emit,
      ) {
    emit(WatchlistSuccess(event.movies));
  }

  void _watchlistError(
      WatchlistErrorEvent event,
      Emitter<WatchlistState> emit,
      ) {
    emit(WatchlistFailure(event.message));
  }

  @override
  Future<void> close() {
    _watchlistSubscription?.cancel();
    return super.close();
  }
}