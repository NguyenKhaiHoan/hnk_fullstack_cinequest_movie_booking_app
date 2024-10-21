part of 'now_playing_movie_bloc.dart';

/// Các sự kiện
@freezed
class NowPlayingMovieEvent with _$NowPlayingMovieEvent {
  /// Sự kiện lấy dữ liệu các movie
  const factory NowPlayingMovieEvent.get() = EventGetNowPlayingMovie;
}
