part of 'trailers_movie_bloc.dart';

@freezed
class TrailersMovieEvent with _$TrailersMovieEvent {
  const factory TrailersMovieEvent.get({required int movieId}) =
      _TrailerMovieGetEvent;
}
