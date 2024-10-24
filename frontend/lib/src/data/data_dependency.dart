import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/data/auth/datasources/auth_remote_datasource.dart';
import 'package:cinequest/src/data/auth/datasources/user_remote_datasource.dart';
import 'package:cinequest/src/data/movie/datasources/movie_remote_datasource.dart';
import 'package:cinequest/src/external/apis/cinequest/cinequest_api.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_api.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';

class DataDependency {
  DataDependency._();

  static void init() {
    sl
      // Data Sources: registerLazySingleton
      ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
          cineQuestApi: sl<CineQuestApi>(),
          secureStorageService: sl<SecureStorageService>(),
        ),
      )
      ..registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(
          cineQuestApi: sl<CineQuestApi>(),
        ),
      )
      ..registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(tmdbApi: sl<TMDBApi>()));
  }
}
