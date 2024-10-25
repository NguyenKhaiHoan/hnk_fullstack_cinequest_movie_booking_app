part of 'cinequest_movie.dart';

mixin CineQuestMovieMixin on State<CineQuestMovie> {
  void _listenerConnectivity(BuildContext context, ConnectivityState state) {
    state.whenOrNull(
      failure: (failure) => ToastUtil.showToastError(context, failure.message),
    );
  }

  void _listenerApp(BuildContext context, AppState state) {
    state.whenOrNull(
      unauthenticated: (failure) {
        if (failure != null) {
          ToastUtil.showToastError(context, failure.message);
        }
      },
    );
  }
}
