import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/search_movie_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovieUseCase searchMovieUseCase;

  SearchBloc({
    required this.searchMovieUseCase,
  }) : super(SearchInitial()) {
    on<SearchMovieEvent>(_onSearchMovie);
  }

  Future<void> _onSearchMovie(
      SearchMovieEvent event,
      Emitter<SearchState> emit,
      ) async {
    emit(SearchLoading());

    try {
      final movies = await searchMovieUseCase(event.query);

      emit(SearchSuccess(movies));
    } catch (e) {
      emit(
        SearchFailure(
          e.toString(),
        ),
      );
    }
  }

}