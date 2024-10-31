part of 'details_movie_bloc.dart';

@freezed
class DetailsMovieEvent with _$DetailsMovieEvent {
  const factory DetailsMovieEvent.get({required int movieId}) =
      _DetailsMovieGetEvent;
}
