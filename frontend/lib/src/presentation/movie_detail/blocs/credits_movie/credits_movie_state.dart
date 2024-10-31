part of 'credits_movie_bloc.dart';

@freezed
class CreditsMovieState with _$CreditsMovieState {
  const factory CreditsMovieState.loading() = _CreditsMovieInitialState;
  const factory CreditsMovieState.success({
    required Credits creditsMovie,
  }) = _CreditsMovieSuccessState;
  const factory CreditsMovieState.failure({required Failure failure}) =
      _CreditsMovieFailureState;
}
