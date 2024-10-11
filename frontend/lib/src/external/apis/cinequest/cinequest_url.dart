/// Các url được sử dụng trong Cinequest
class CineQuestUrl {
  CineQuestUrl._();

  static const baseUrl = 'http://localhost:8080/v1/';

  static const getFavoritesUrl = '/account/favorite/movies';
  static const addFavoriteUrl = 'account/favorite';

  static const loginUrl = '/auth/login';
  static const signUpUrl = '/auth/sign-up';
  static const verifyUrl = '/auth/verify';
  static const resendCodeUrl = '/auth/resend-code';
  static const refreshTokenUrl = '/auth/resend-code';
  static const forgotPasswordUrl = '/auth/forgot-pasword';
}
