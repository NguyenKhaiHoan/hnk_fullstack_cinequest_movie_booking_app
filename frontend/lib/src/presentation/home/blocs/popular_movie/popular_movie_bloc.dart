import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/domain/movie/usecases/get_popular_movie_usecase.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_movie_bloc.freezed.dart';
part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  PopularMovieBloc(this._useCase) : super(const PopularMovieState.loading()) {
    on<PopularMovieEvent>((event, emit) async {
      await event.map(get: (e) => _onGet(e, emit));
    });
  }

  final GetPopularMoviesUseCase _useCase;

  Future<void> _onGet(
    _PopularMovieGetEvent e,
    Emitter<PopularMovieState> emit,
  ) async {
    final result = await _useCase.call(params: const MovieListParams());

    result.fold((failure) {
      emit(PopularMovieState.failure(failure: failure));
    }, (data) {
      emit(PopularMovieState.success(movies: data));
    });
  }
}
