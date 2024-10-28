part of 'popular_movie_bloc.dart';

/// Các sự kiện
@freezed
class PopularMovieEvent with _$PopularMovieEvent {
  /// Sự kiện lấy dữ liệu các movie
  const factory PopularMovieEvent.get() = EventGetPopularMovie;
}
