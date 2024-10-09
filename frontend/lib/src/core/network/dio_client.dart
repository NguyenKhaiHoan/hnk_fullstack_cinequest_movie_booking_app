import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Cài đặt client cho Dio
class DioClient {
  /// Constructor
  DioClient() {
    _dio = Dio();

    _dio
      ..options.headers = {
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        // HttpHeaders.authorizationHeader: 'Bearer ${Env.accessToken}',
      }
      ..options.connectTimeout = const Duration(milliseconds: 15000)
      ..options.receiveTimeout = const Duration(milliseconds: 15000)
      ..options.responseType = ResponseType.json
      ..interceptors.add(
        PrettyDioLogger(
          compact: false,
          logPrint: (object) => log(object.toString(), name: 'TMDB API'),
        ),
      );
  }
  late final Dio _dio;

  /// get dio
  Dio get dio => _dio;
}
