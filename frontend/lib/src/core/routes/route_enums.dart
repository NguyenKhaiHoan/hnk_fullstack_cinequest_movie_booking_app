// Địng nghĩa các tuyến đường trong App
enum AppRoutes {
  welcome('/welcome'),
  splash('/'),
  login('/login'),
  signUp('/signUp'),
  findingLocation('/findingLocation'),
  invalidLocation('/invalidLocation'),
  accountSetup('/accountSetup'),
  resetPassword('/resetPassword'),
  ticket('/ticket'),
  home('/home'),
  selectLocation('/selectLocation'),
  searchMovie('/searchMovie'),
  profile('/profile'),
  setting('/setting'),
  movieDetail('/movieDetail');

  const AppRoutes(this.path);
  final String path;
}

enum PageTransitionDirection {
  left,
  up,
  right,
  down,
}
