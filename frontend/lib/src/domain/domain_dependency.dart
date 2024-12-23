import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/data/auth/datasources/auth_remote_datasource.dart';
import 'package:cinequest/src/data/auth/datasources/user_remote_datasource.dart';
import 'package:cinequest/src/data/auth/repositories/auth_repository_impl.dart';
import 'package:cinequest/src/data/auth/repositories/user_repository_impl.dart';
import 'package:cinequest/src/data/location/datasources/city_local_datasource.dart';
import 'package:cinequest/src/data/location/repositories/city_repository_impl.dart';
import 'package:cinequest/src/data/movie/datasources/movie_remote_datasource.dart';
import 'package:cinequest/src/data/movie/repositories/movie_respository_impl.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
import 'package:cinequest/src/domain/auth/repositories/user_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/forgot_password_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/get_user_details_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/get_user_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/login_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/resend_code_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/setup_account_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/sign_up_usecase.dart';
import 'package:cinequest/src/domain/auth/usecases/verify_user_usecase.dart';
import 'package:cinequest/src/domain/location/repositories/city_repository.dart';
import 'package:cinequest/src/domain/location/usecases/get_cities_usecase.dart';
import 'package:cinequest/src/domain/location/usecases/search_city_usecase.dart';
import 'package:cinequest/src/domain/movie/repositories/movie_repository.dart';
import 'package:cinequest/src/domain/movie/usecases/get_credits_movie_usecase.dart';
import 'package:cinequest/src/domain/movie/usecases/get_details_movie_usecase.dart';
import 'package:cinequest/src/domain/movie/usecases/get_now_playing_movies_usecase.dart';
import 'package:cinequest/src/domain/movie/usecases/get_popular_movie_usecase.dart';
import 'package:cinequest/src/domain/movie/usecases/get_videos_movie_usecase.dart';

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
      ..registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
          movieRemoteDataSource: sl<MovieRemoteDataSource>(),
        ),
      )
      ..registerLazySingleton<CityRepository>(
        () => CityRepositoryImpl(
          cityLocalDataSource: sl<CityLocalDataSource>(),
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
      )
      ..registerLazySingleton<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(
          sl<AuthRepository>(),
        ),
      )
      ..registerLazySingleton<ResendCodeUseCase>(
        () => ResendCodeUseCase(
          sl<AuthRepository>(),
        ),
      )
      ..registerLazySingleton<GetPopularMoviesUseCase>(
        () => GetPopularMoviesUseCase(
          sl<MovieRepository>(),
        ),
      )
      ..registerLazySingleton<GetNowPlayingMoviesUseCase>(
        () => GetNowPlayingMoviesUseCase(
          sl<MovieRepository>(),
        ),
      )
      ..registerLazySingleton<GetDetailsMovieUseCase>(
        () => GetDetailsMovieUseCase(
          sl<MovieRepository>(),
        ),
      )
      ..registerLazySingleton<GetVideosMovieUseCase>(
        () => GetVideosMovieUseCase(
          sl<MovieRepository>(),
        ),
      )
      ..registerLazySingleton<GetCreditsMovieUseCase>(
        () => GetCreditsMovieUseCase(
          sl<MovieRepository>(),
        ),
      )
      ..registerLazySingleton<GetCitiesUseCase>(
        () => GetCitiesUseCase(
          sl<CityRepository>(),
        ),
      )
      ..registerLazySingleton<SearchCityUseCase>(
        () => SearchCityUseCase(
          sl<CityRepository>(),
        ),
      );
  }
}
