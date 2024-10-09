/// Params của các use case GetNowPlayingMovie, GetPopularMovie, ...
class GetMoviesApiParams {
  /// Constructor
  GetMoviesApiParams({
    this.page = 1,
    this.language = 'en',
  });

  final int page;
  final String language;
}
