part of '../carousel_now_playing_movie.dart';

mixin CarouselNowPlayingMovieMixin on State<CarouselNowPlayingMovie> {
  void _toggleFavorite(
    BuildContext context,
    List<Movie> favoriteMovies,
    Movie movie,
    bool isFavorite,
  ) {
    if (isFavorite) {
    } else {}
  }

  void _listener(
    BuildContext context,
    ButtonState state,
  ) {
    state.whenOrNull(
      failure: (failure) => context.showSnackbar(context, failure.message),
    );
  }
}
