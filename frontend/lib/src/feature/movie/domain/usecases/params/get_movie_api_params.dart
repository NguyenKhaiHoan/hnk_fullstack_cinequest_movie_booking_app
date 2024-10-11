/// Params của các use case GetNowPlayingMovie, GetPopularMovie, ...
class MovieListParams {
  /// Constructor
  MovieListParams({
    this.language = 'en-US',
    this.page = 1,
  });

  final int page;
  final String language;
}
