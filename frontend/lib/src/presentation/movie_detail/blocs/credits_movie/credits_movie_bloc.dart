import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/domain/movie/entities/credits.dart';
import 'package:cinequest/src/domain/movie/usecases/get_credits_movie_usecase.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_details_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_movie_bloc.freezed.dart';
part 'credits_movie_event.dart';
part 'credits_movie_state.dart';

class CreditsMovieBloc extends Bloc<CreditsMovieEvent, CreditsMovieState> {
  CreditsMovieBloc(this._useCase) : super(const CreditsMovieState.loading()) {
    on<CreditsMovieEvent>((event, emit) async {
      await event.map(get: (e) => _onGet(e, emit));
    });
  }

  final GetCreditsMovieUseCase _useCase;

  Future<void> _onGet(
    _CreditsMovieGetEvent e,
    Emitter<CreditsMovieState> emit,
  ) async {
    final result = await _useCase.call(
      params: MovieDetailsParams(movieId: e.movieId),
    );

    result.fold((failure) {
      emit(CreditsMovieState.failure(failure: failure));
    }, (data) {
      emit(CreditsMovieState.success(creditsMovie: data));
    });
  }
}
