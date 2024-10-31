part of 'ratings_movie_bloc.dart';

@freezed
class RatingsMovieState with _$RatingsMovieState {
  const factory RatingsMovieState.loading() = _RatingsMovieInitialState;
  const factory RatingsMovieState.success({
    required List<Review> reviews,
  }) = _RatingsMovieSuccessState;
  const factory RatingsMovieState.failure({required Failure failure}) =
      _RatingsMovieFailureState;
}
