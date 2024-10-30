part of 'popular_movie_bloc.dart';

@freezed
class PopularMovieState with _$PopularMovieState {
  const factory PopularMovieState.loading() = _PopularMovieLoadingState;
  const factory PopularMovieState.success({required List<Movie> movies}) =
      _PopularMovieSuccessState;
  const factory PopularMovieState.failure({required Failure failure}) =
      _PopularMovieFailureState;
}
