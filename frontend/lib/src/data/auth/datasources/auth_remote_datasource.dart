import 'package:cinequest/src/common/constants/app_constant.dart';
import 'package:cinequest/src/core/errors/exception/network_exception.dart';
import 'package:cinequest/src/core/errors/exception/no_internet_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:cinequest/src/data/auth/models/responses/token_response.dart';
import 'package:cinequest/src/domain/auth/usecases/params/email_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/login_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/sign_up_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/verify_user_params.dart';
import 'package:cinequest/src/external/apis/cinequest/cinequest_api.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp(SignUpParams params);
  Future<TokenResponse> login(LoginParams params);
  Future<void> logOut();
  Future<TokenResponse> verifyUser(VerifyUserParams params);
  Future<void> forgotPassword(EmailParams params);
  Future<void> resendCode(EmailParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required CineQuestApi cineQuestApi,
    required SecureStorageService secureStorageService,
  })  : _cineQuestApi = cineQuestApi,
        _secureStorageService = secureStorageService;

  final CineQuestApi _cineQuestApi;
  final SecureStorageService _secureStorageService;

  @override
  Future<void> signUp(SignUpParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        return await _cineQuestApi.signUp(params: params);
      } on DioException catch (e) {
        throw Failure(
          message: NetworkException.fromDioException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<TokenResponse> login(LoginParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final result = await _cineQuestApi.login(params: params);
        await _secureStorageService.saveData(
          AppConstant.accessToken,
          result.accessToken,
        );
        await _secureStorageService.saveData(
          AppConstant.accessExpiration,
          result.accessTokenExpiresAt,
        );
        return result;
      } on DioException catch (e) {
        throw Failure(
          message: NetworkException.fromDioException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<void> logOut() async {
    if (await ConnectivityUtil.checkConnectivity()) {
      // Todo
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<TokenResponse> verifyUser(VerifyUserParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final result = await _cineQuestApi.verify(params: params);
        await _secureStorageService.saveData(
          AppConstant.accessToken,
          result.accessToken,
        );
        await _secureStorageService.saveData(
          AppConstant.accessExpiration,
          result.accessTokenExpiresAt,
        );
        return result;
      } on DioException catch (e) {
        throw Failure(
          message: NetworkException.fromDioException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<void> forgotPassword(EmailParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        return await _cineQuestApi.forgotPassword(params: params);
      } on DioException catch (e) {
        throw Failure(
          message: NetworkException.fromDioException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<void> resendCode(EmailParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        return await _cineQuestApi.resendCode(params: params);
      } on DioException catch (e) {
        throw Failure(
          message: NetworkException.fromDioException(e).message,
          exception: e,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }
}
