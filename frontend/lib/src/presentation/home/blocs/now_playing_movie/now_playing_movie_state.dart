part of 'now_playing_movie_bloc.dart';

@freezed
class NowPlayingMovieState with _$NowPlayingMovieState {
  const factory NowPlayingMovieState.loading() = _NowPlayingMovieLoadingState;
  const factory NowPlayingMovieState.success({required List<Movie> movies}) =
      _NowPlayingMovieSuccessState;
  const factory NowPlayingMovieState.failure({required Failure failure}) =
      _NowPlayingMovieFailureState;
}
