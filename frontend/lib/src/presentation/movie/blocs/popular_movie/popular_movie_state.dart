part of 'popular_movie_bloc.dart';

@freezed
class PopularMovieState with _$PopularMovieState {
  const factory PopularMovieState.loading() = InitialPopularMovieState;
  const factory PopularMovieState.success({required List<Movie> movies}) =
      SuccessPopularMovieState;
  const factory PopularMovieState.failure({required Failure failure}) =
      FailurePopularMovieState;
}
