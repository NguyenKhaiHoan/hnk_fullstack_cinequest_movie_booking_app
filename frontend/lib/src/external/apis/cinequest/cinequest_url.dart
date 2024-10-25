class CineQuestUrl {
  CineQuestUrl._();

  static const baseUrl = 'http://10.10.166.149:8080/'; // Ipconfig Wifi Ipv4

  static const loginUrl = '/auth/login';
  static const signUpUrl = '/auth/sign-up';
  static const verifyUrl = '/auth/verify';
  static const resendCodeUrl = '/auth/resend-code';
  static const refreshTokenUrl = '/auth/refresh-token';
  static const forgotPasswordUrl = '/auth/forgot-password';

  static const getFavoritesUrl = '/favorite/{user_id}';
  static const addFavoriteUrl = '/favorite/{user_id}/add';
  static const deleteFavoriteUrl = '/favorite/{user_id}/delete/{movie_id}';

  static const getUserUrl = '/account';
  static const setupAccountUrl = '/account/setup';
  static const getUserDetailsUrl = '/account/details/{user_id}';
  static const updateUserDetailsUrl = '/account/details/{user_id}';
}
