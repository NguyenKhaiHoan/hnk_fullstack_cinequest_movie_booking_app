import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/data/auth/datasources/auth_remote_datasource.dart';
import 'package:cinequest/src/data/auth/datasources/user_remote_datasource.dart';
import 'package:cinequest/src/data/auth/repositories/auth_repository_impl.dart';
import 'package:cinequest/src/data/auth/repositories/user_repository_impl.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
import 'package:cinequest/src/domain/auth/repositories/user_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/get_user_details_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/get_user_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/login_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/setup_account_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/sign_up_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/verify_user_usecase.dart';

class DomainDependency {
  DomainDependency._();

  static void init() {
    sl
      // Repositories: registerLazySingleton
      ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
          authRemoteDataSource: sl<AuthRemoteDataSource>(),
        ),
      )
      ..registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(
          userRemoteDataSource: sl<UserRemoteDataSource>(),
        ),
      )

      // UseCases: registerLazySingleton
      ..registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(
          sl<AuthRepository>(),
        ),
      )
      ..registerLazySingleton<SignUpUseCase>(
        () => SignUpUseCase(
          sl<AuthRepository>(),
        ),
      )
      ..registerLazySingleton<VerifyUserUseCase>(
        () => VerifyUserUseCase(
          sl<AuthRepository>(),
        ),
      )
      ..registerLazySingleton<GetUserUseCase>(
        () => GetUserUseCase(
          sl<UserRepository>(),
        ),
      )
      ..registerLazySingleton<GetUserDetailsUseCase>(
        () => GetUserDetailsUseCase(
          sl<UserRepository>(),
        ),
      )
      ..registerLazySingleton<SetupAccountUseCase>(
        () => SetupAccountUseCase(
          sl<UserRepository>(),
        ),
      );
  }
}
