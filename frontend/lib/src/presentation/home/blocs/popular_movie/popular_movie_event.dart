part of 'popular_movie_bloc.dart';

@freezed
class PopularMovieEvent with _$PopularMovieEvent {
  const factory PopularMovieEvent.get() = _PopularMovieGetEvent;
}
