import 'package:cinequest/src/common/blocs/app/app_bloc.dart';
import 'package:cinequest/src/common/blocs/connectivity/connectivity_bloc.dart';
import 'package:cinequest/src/common/service/location_stream_service.dart';
import 'package:cinequest/src/common/service/user_details_stream_service.dart';
import 'package:cinequest/src/core/di/injection_container.dart';

class CommonDependency {
  CommonDependency._();

  static void init() {
    sl
      ..registerLazySingleton<LocationStreamService>(
        LocationStreamService.new,
      )
      ..registerLazySingleton<UserDetailsStreamService>(
        UserDetailsStreamService.new,
      )
      ..registerFactory<AppBloc>(
        () => AppBloc(
          locationStreamService: sl(),
          locationService: sl(),
          getStorageService: sl(),
          userDetailsStreamService: sl(),
          getUserUseCase: sl(),
          getUserDetailsUseCase: sl(),
          secureStorageService: sl(),
        ),
      )
      ..registerFactory<ConnectivityBloc>(
        () => ConnectivityBloc(connectivityService: sl()),
      );
  }
}
