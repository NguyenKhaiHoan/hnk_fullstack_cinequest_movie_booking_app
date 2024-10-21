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
      sendTimeout: const Duration(milliseconds: 15000),
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 15000),
    ),
  );

  final SecureStorageService _secureStorageService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken =
        await _secureStorageService.getData('ACCESS_TOKEN') ?? '';
    if (accessToken != '') {
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
      try {
        await refreshToken();
        final response = await _retry(err.requestOptions);
        handler.resolve(response);
      } catch (e) {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> refreshToken() async {
    final accessToken =
        await _secureStorageService.getData('REFRESH_TOKEN') ?? '';
    try {
      final response = await _dio.post<TokenResponse>(
        CineQuestUrl.baseUrl + CineQuestUrl.refreshTokenUrl.substring(1),
        data: {'token': accessToken},
      );
      if (response.statusCode == 200) {
        await _secureStorageService.saveData(
          'ACCESS_TOKEN',
          response.data!.accessToken,
        );
        await _secureStorageService.saveData(
          'ACCESS_EXPIRATION',
          response.data!.accessTokenExpiresAt,
        );
      } else {
        throw Exception('Không thể làm mới token');
      }
    } on DioException catch (e) {
      throw Exception('Không thể làm mới token: ${e.message}');
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final accessToken = await _secureStorageService.getData('ACCESS_TOKEN');
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
