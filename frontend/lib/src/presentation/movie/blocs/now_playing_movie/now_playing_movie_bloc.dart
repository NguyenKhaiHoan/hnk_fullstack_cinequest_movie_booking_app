import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/domain/movie/usecases/get_now_playing_movies_usecase.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'now_playing_movie_bloc.freezed.dart';
part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  NowPlayingMovieBloc(this._useCase)
      : super(const NowPlayingMovieState.loading()) {
    on<NowPlayingMovieEvent>((events, emit) async {
      await events.map(get: (event) => _onGet(event, emit));
    });
  }

  final GetNowPlayingMoviesUseCase _useCase;

  Future<void> _onGet(
    EventGetNowPlayingMovie event,
    Emitter<NowPlayingMovieState> emit,
  ) async {
    final result = await _useCase.call(params: const MovieListParams());

    result.fold((failure) {
      emit(NowPlayingMovieState.failure(failure: failure));
    }, (data) {
      emit(NowPlayingMovieState.success(movies: data));
    });
  }
}
