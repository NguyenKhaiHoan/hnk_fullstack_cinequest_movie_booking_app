import 'dart:developer';

import 'package:cinequest/src/common/constants/app_keys.dart';
import 'package:cinequest/src/core/errors/exception/network_exception.dart';
import 'package:cinequest/src/core/errors/exception/no_internet_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:cinequest/src/data/auth/models/requests/login_request.dart';
import 'package:cinequest/src/data/auth/models/requests/sign_up_request.dart';
import 'package:cinequest/src/data/auth/models/requests/verify_user_request.dart';
import 'package:cinequest/src/data/auth/models/responses/token_response.dart';
import 'package:cinequest/src/external/apis/cinequest/cinequest_api.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUp(SignUpRequest request);
  Future<TokenResponse> login(LoginRequest request);
  Future<void> logOut();
  Future<TokenResponse> verifyUser(VerifyUserRequest request);
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
  Future<void> signUp(SignUpRequest request) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        return await _cineQuestApi.signUp(request: request);
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
  Future<TokenResponse> login(LoginRequest request) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final result = await _cineQuestApi.login(request: request);
        await _secureStorageService.saveData(
          AppKeys.accessToken,
          result.accessToken,
        );
        await _secureStorageService.saveData(
          AppKeys.accessExpiration,
          result.accessTokenExpiresAt,
        );
        log('------------- access token: ${result.accessToken}');
        log('------------- access expiration: ${result.accessTokenExpiresAt}');
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
  Future<TokenResponse> verifyUser(VerifyUserRequest request) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        return await _cineQuestApi.verify(request: request);
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
