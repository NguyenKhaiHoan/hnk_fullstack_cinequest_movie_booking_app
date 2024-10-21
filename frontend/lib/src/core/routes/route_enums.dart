// Địng nghĩa các tuyến đường trong App
enum AppRoutes {
  welcome('/welcome'),
  splash('/'),
  login('/login'),
  signUp('/signUp'),
  accountSetup('/accountSetup'),
  resetPassword('/resetPassword'),
  ticket('/ticket'),
  home('/home'),
  profile('/profile'),
  setting('/setting');

  const AppRoutes(this.path);
  final String path;
}

enum PageTransitionDirection {
  left,
  up,
  right,
  down,
}
