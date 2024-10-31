part of 'ratings_movie_bloc.dart';

@freezed
class RatingsMovieEvent with _$RatingsMovieEvent {
  const factory RatingsMovieEvent.get({required int movieId}) =
      _RatingsMovieGetEvent;
}
