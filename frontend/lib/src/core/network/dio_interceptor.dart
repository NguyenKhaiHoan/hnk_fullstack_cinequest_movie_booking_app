import 'dart:developer';

import 'package:cinequest/src/common/constants/app_constant.dart';
import 'package:cinequest/src/core/errors/exception/network_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/routes/route_pages.dart';
import 'package:cinequest/src/data/auth/models/responses/token_response.dart';
import 'package:cinequest/src/external/apis/cinequest/cinequest_url.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  DioInterceptor({
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService;

  final Dio _dio = Dio(
    BaseOptions(
      sendTimeout: const Duration(milliseconds: 60000),
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
    ),
  );

  final SecureStorageService _secureStorageService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken =
        await _secureStorageService.getData(AppConstant.accessToken);
    log('------------- access token: $accessToken');
    if (accessToken != null) {
      options.headers.addAll({
        'Authorization': 'Bearer $accessToken',
      });
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final accessToken =
          await _secureStorageService.getData(AppConstant.accessToken);
      final accessExpiration =
          await _secureStorageService.getData(AppConstant.accessExpiration);
      log('------------- access token: $accessToken');
      log('------------- access expiration: $accessExpiration');

      if (accessToken != null && accessExpiration != null) {
        final expirationDate = DateTime.parse(accessExpiration);
        if (expirationDate.isBefore(DateTime.now())) {
          try {
            await refreshToken();
            final response = await _retry(err.requestOptions);
            handler.resolve(response);
          } catch (e) {
            await _secureStorageService.remove(
              AppConstant.accessToken,
            );
            await _secureStorageService.remove(
              AppConstant.accessExpiration,
            );
            RouterPages.refreshPath();
            RouterPages.router.refresh();
          }
        }
      } else {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> refreshToken() async {
    final accessToken =
        await _secureStorageService.getData(AppConstant.accessToken);
    try {
      final refreshTokenUrl =
          CineQuestUrl.baseUrl + CineQuestUrl.refreshTokenUrl.substring(1);
      final response = await _dio.post<Map<String, dynamic>>(
        refreshTokenUrl,
        data: {'token': accessToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final tokenResponse = TokenResponse.fromJson(
          response.data!,
        ); // Convert the response
        await _secureStorageService.saveData(
          AppConstant.accessToken,
          tokenResponse.accessToken,
        );
        await _secureStorageService.saveData(
          AppConstant.accessExpiration,
          tokenResponse.accessTokenExpiresAt,
        );
        log('------------- access token (after refresh): ${tokenResponse.accessToken}');
        log('------------- access expiration (after refresh): ${tokenResponse.accessTokenExpiresAt}');
      } else {
        throw DioException(
          error: response.statusMessage,
          response: response,
          requestOptions: response.requestOptions,
        );
      }
    } on DioException catch (e) {
      throw Failure(message: NetworkException.fromDioException(e).message);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final accessToken =
        await _secureStorageService.getData(AppConstant.accessToken);
    final options = Options(
      method: requestOptions.method,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    return _dio.request<dynamic>(
      CineQuestUrl.baseUrl + requestOptions.path.substring(1),
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
