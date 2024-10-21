class TMDBUrl {
  TMDBUrl._();

  static const baseUrl = 'https://api.themoviedb.org/3/';
  static const imageBaseUrl = 'https://image.tmdb.org/t/p/w500/';

  static const getNowPlayingMoviesUrl = '/movie/now_playing';
  static const getPopularMoviesUrl = '/movie/popular';
  static const getSimilarMoviesUrl = '/movie/{movie_id}/similar';
  static const getDetailMovieUrl = '/movie/{movie_id}';
  static const getCreditsMovieUrl = '/movie/{movie_id}/credits';
  static const getVideosMovieUrl = '/movie/{movie_id}/videos';
  static const searchMovieUrlUrl = '/search/movie';
}
