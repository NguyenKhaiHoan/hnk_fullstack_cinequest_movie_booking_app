part of 'cinequest_movie.dart';

/// Mixin của CineQuestMovie xử lý logic UI
mixin CineQuestMovieMixin on State<CineQuestMovie> {
  void _listenerConnectivity(BuildContext context, ConnectivityState state) {
    state.whenOrNull(
      failure: (failure) => context.showSnackbar(
        context,
        failure.message,
      ),
    );
  }

  void _listenerApp(BuildContext context, AppState state) {
    state.whenOrNull(
      unauthenticated: (failure) {
        if (failure != null) {
          context.showSnackbar(context, failure.message);
        }
      },
    );
  }
}
