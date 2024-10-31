part of 'trailers_movie_bloc.dart';

@freezed
class TrailersMovieState with _$TrailersMovieState {
  const factory TrailersMovieState.loading() = _TrailersMovieInitialState;
  const factory TrailersMovieState.success({
    required List<Video> videos,
  }) = _TrailersMovieSuccessState;
  const factory TrailersMovieState.failure({required Failure failure}) =
      _TrailersMovieFailureState;
}
