import 'dart:io';

import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/network/model/response.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class NetworkException extends Equatable {
  NetworkException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = 'The request to the API server was cancelled'.hardcoded;
      case DioExceptionType.connectionTimeout:
        message = 'Connection to the API server timed out'.hardcoded;
      case DioExceptionType.receiveTimeout:
        message = 'Receiving response from the API server timed out'.hardcoded;
      case DioExceptionType.sendTimeout:
        message = 'Sending data to the API server timed out'.hardcoded;
      case DioExceptionType.connectionError:
        if (dioException.error is SocketException) {
          message = 'Please check your internet connection'.hardcoded;
        } else {
          message = 'An unexpected error occurred'.hardcoded;
        }
      case DioExceptionType.badCertificate:
        message = 'Invalid certificate received from the server'.hardcoded;
      case DioExceptionType.badResponse:
        final response = ApiResponse.fromJson(
          dioException.response?.data as Map<String, dynamic>,
        );
        message = response.statusMessage ??
            'Invalid response from the API server'.hardcoded;
      case DioExceptionType.unknown:
        message = 'An unknown error occurred'.hardcoded;
    }
  }

  late final String message;

  @override
  List<Object?> get props => [message];
}
