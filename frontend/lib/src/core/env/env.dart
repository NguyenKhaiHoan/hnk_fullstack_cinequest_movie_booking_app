import 'package:envied/envied.dart';

part 'env.g.dart';

/// Các biến môi trường
@Envied(path: '.env')
final class Env {
  /// Api key của TheMovieDb
  @EnviedField(varName: 'THEMOVIEDB_API_KEY', obfuscate: true)
  static final String theMovieDbApiKey = _Env.theMovieDbApiKey;
}
