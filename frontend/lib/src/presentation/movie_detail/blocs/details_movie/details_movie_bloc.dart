import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/domain/movie/entities/movie_detail.dart';
import 'package:cinequest/src/domain/movie/usecases/get_details_movie_usecase.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_details_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'details_movie_bloc.freezed.dart';
part 'details_movie_event.dart';
part 'details_movie_state.dart';

class DetailsMovieBloc extends Bloc<DetailsMovieEvent, DetailsMovieState> {
  DetailsMovieBloc(this._useCase) : super(const DetailsMovieState.loading()) {
    on<DetailsMovieEvent>((event, emit) async {
      await event.map(get: (e) => _onGet(e, emit));
    });
  }

  final GetDetailsMovieUseCase _useCase;

  Future<void> _onGet(
    _DetailsMovieGetEvent e,
    Emitter<DetailsMovieState> emit,
  ) async {
    final result = await _useCase.call(
      params: MovieDetailsParams(movieId: e.movieId),
    );

    result.fold((failure) {
      emit(DetailsMovieState.failure(failure: failure));
    }, (data) {
      emit(DetailsMovieState.success(movieDetails: data));
    });
  }
}
