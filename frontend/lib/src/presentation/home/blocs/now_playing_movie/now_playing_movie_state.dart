part of 'now_playing_movie_bloc.dart';

@freezed
class NowPlayingMovieState with _$NowPlayingMovieState {
  const factory NowPlayingMovieState.loading() = InitialNowPlayingMovieState;
  const factory NowPlayingMovieState.success({required List<Movie> movies}) =
      SuccessNowPlayingMovieState;
  const factory NowPlayingMovieState.failure({required Failure failure}) =
      FailureNowPlayingMovieState;
}
