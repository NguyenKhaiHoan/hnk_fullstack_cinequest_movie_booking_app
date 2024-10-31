import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/domain/movie/entities/video.dart';
import 'package:cinequest/src/domain/movie/usecases/get_videos_movie_usecase.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_details_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trailers_movie_bloc.freezed.dart';
part 'trailers_movie_event.dart';
part 'trailers_movie_state.dart';

class TrailersMovieBloc extends Bloc<TrailersMovieEvent, TrailersMovieState> {
  TrailersMovieBloc(this._useCase) : super(const TrailersMovieState.loading()) {
    on<TrailersMovieEvent>((event, emit) async {
      await event.map(get: (e) => _onGet(e, emit));
    });
  }

  final GetVideosMovieUseCase _useCase;

  Future<void> _onGet(
    _TrailerMovieGetEvent e,
    Emitter<TrailersMovieState> emit,
  ) async {
    final result = await _useCase.call(
      params: MovieDetailsParams(movieId: e.movieId),
    );

    result.fold((failure) {
      emit(TrailersMovieState.failure(failure: failure));
    }, (data) {
      emit(TrailersMovieState.success(videos: data));
    });
  }
}
