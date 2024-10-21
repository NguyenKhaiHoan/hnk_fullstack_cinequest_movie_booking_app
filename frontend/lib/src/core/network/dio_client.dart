import 'dart:io';

import 'package:cinequest/src/core/network/dio_interceptor.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  DioClient({
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService {
    _dio = Dio();

    _dio
      ..options.headers = {
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      }
      ..options.connectTimeout = const Duration(milliseconds: 15000)
      ..options.receiveTimeout = const Duration(milliseconds: 15000)
      ..options.responseType = ResponseType.json
      ..interceptors.add(
        PrettyDioLogger(),
      )
      ..interceptors.add(
        DioInterceptor(
          secureStorageService: _secureStorageService,
        ),
      );
  }

  final SecureStorageService _secureStorageService;
  late final Dio _dio;
  Dio get dio => _dio;
}
