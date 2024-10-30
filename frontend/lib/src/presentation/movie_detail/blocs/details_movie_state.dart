part of 'details_movie_bloc.dart';

@freezed
class DetailsMovieState with _$DetailsMovieState {
  const factory DetailsMovieState.loading() = _DetailsMovieInitialState;
  const factory DetailsMovieState.success({
    required MovieDetails movieDetails,
  }) = _DetailsMovieSuccessState;
  const factory DetailsMovieState.failure({required Failure failure}) =
      _DetailsMovieFailureState;
}
