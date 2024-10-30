import 'dart:io';

import 'package:cinequest/src/core/errors/exception/network_exception.dart';
import 'package:cinequest/src/core/errors/exception/no_internet_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:cinequest/src/data/auth/models/user_details_model.dart';
import 'package:cinequest/src/data/auth/models/user_model.dart';
import 'package:cinequest/src/external/apis/cinequest/cinequest_api.dart';
import 'package:dio/dio.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser();
  Future<UserDetailsModel> getUserDetails({required String params});
  Future<UserDetailsModel> setupAccount({
    required File file,
    required String userDetails,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl({
    required CineQuestApi cineQuestApi,
  }) : _cineQuestApi = cineQuestApi;

  final CineQuestApi _cineQuestApi;

  @override
  Future<UserModel> getUser() async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        return await _cineQuestApi.getUser();
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
  Future<UserDetailsModel> getUserDetails({required String params}) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final result = await _cineQuestApi.getUserDetails(userId: params);
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
  Future<UserDetailsModel> setupAccount({
    required File file,
    required String userDetails,
  }) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final result = await _cineQuestApi.setupAccount(
          file: file,
          userDetails: userDetails,
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
}
