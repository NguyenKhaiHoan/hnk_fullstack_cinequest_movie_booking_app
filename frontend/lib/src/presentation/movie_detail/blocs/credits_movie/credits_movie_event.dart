part of 'credits_movie_bloc.dart';

@freezed
class CreditsMovieEvent with _$CreditsMovieEvent {
  const factory CreditsMovieEvent.get({required int movieId}) =
      _CreditsMovieGetEvent;
}
