import 'package:cinequest/src/common/blocs/app/app_bloc.dart';
import 'package:cinequest/src/common/blocs/connectivity/connectivity_bloc.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/domain/auth/usecases/get_user_details_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/get_user_usecase.dart';
import 'package:cinequest/src/external/services/connectivity/connectivity_service.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';

class CommonDependency {
  CommonDependency._();

  static void init() {
    sl
      ..registerFactory<AppBloc>(
        () => AppBloc(
          getUserUseCase: sl<GetUserUseCase>(),
          getUserDetailsUseCase: sl<GetUserDetailsUseCase>(),
          secureStorageService: sl<SecureStorageService>(),
        ),
      )
      ..registerFactory<ConnectivityBloc>(
        () => ConnectivityBloc(connectivityService: sl<ConnectivityService>()),
      );
  }
}
