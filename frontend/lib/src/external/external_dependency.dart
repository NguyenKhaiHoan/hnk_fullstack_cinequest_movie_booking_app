import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/network/dio_client.dart';
import 'package:cinequest/src/external/apis/cinequest/cinequest_api.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_api.dart';
import 'package:cinequest/src/external/services/connectivity/connectivity_service.dart';
import 'package:cinequest/src/external/services/location/location_service.dart';
import 'package:cinequest/src/external/services/storage/local/get_storage_service.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:cinequest/src/external/services/storage/local/shared_preferences_service.dart';
import 'package:cinequest/src/external/services/storage/local/sqlite_service.dart';

class ExternalDependency {
  ExternalDependency._();

  static void init() {
    sl
      ..registerLazySingleton<GetStorageService>(GetStorageService.new)
      ..registerLazySingleton<SharedPreferencesService>(
        SharedPreferencesService.new,
      )
      ..registerLazySingleton<SqliteService>(
        SqliteService.new,
      )
      ..registerLazySingleton<SecureStorageService>(
        SecureStorageService.new,
      )
      ..registerLazySingleton<DioClient>(
        () => DioClient(secureStorageService: sl<SecureStorageService>()),
      )
      ..registerLazySingleton<TMDBApi>(() => TMDBApi(sl<DioClient>().dio))
      ..registerLazySingleton<CineQuestApi>(
        () => CineQuestApi(sl<DioClient>().dio),
      )
      ..registerLazySingleton<ConnectivityService>(ConnectivityService.new)
      ..registerLazySingleton<LocationService>(LocationService.new);
  }
}
