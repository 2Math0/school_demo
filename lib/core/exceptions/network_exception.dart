import 'package:dio/dio.dart';

import 'app_exception.dart';

class NetworkExceptionHandler {
  // Private constructor to prevent instantiation
  NetworkExceptionHandler._();

  static AppException handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is AppException) {
      return error;
    } else {
      return UnknownException(
        message: 'An unexpected error occurred',
        details: error.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  static AppException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return TimeoutException(
          message: 'Connection timeout. Please check your internet connection.',
          code: 'CONNECTION_TIMEOUT',
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.sendTimeout:
        return TimeoutException(
          message: 'Request timeout. Please try again later.',
          code: 'SEND_TIMEOUT',
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Server response timeout. Please try again later.',
          code: 'RECEIVE_TIMEOUT',
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Invalid SSL certificate. Please try again later.',
          code: 'BAD_CERTIFICATE',
          details: error.message,
          statusCode: error.response?.statusCode,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'Connection error. Please check your internet connection.',
          code: 'CONNECTION_ERROR',
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return NetworkException(
          message: 'Request was cancelled',
          code: 'REQUEST_CANCELLED',
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.unknown:
      default:
        return NetworkException(
          message: 'Network error occurred',
          code: 'UNKNOWN_NETWORK_ERROR',
          details: error.message,
          statusCode: error.response?.statusCode,
          stackTrace: error.stackTrace,
        );
    }
  }

  static AppException _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    String message = 'Server error occurred';

    // Try to extract error message from response
    if (data != null && data is Map<String, dynamic>) {
      if (data.containsKey('message')) {
        message = data['message'] as String;
      } else if (data.containsKey('error')) {
        message = data['error'] is String
            ? data['error'] as String
            : data['error']['message'] as String? ?? message;
      }
    }

    switch (statusCode) {
      case 400:
        return ValidationException(
          message: message,
          code: 'BAD_REQUEST',
          details: data,
          stackTrace: error.stackTrace,
        );

      case 401:
        return AuthException(
          message: 'Unauthorized. Please login again.',
          code: 'UNAUTHORIZED',
          details: data,
          stackTrace: error.stackTrace,
        );

      case 403:
        return PermissionException(
          message: 'You do not have permission to access this resource',
          code: 'FORBIDDEN',
          details: data,
          stackTrace: error.stackTrace,
        );

      case 404:
        return NetworkException(
          message: 'The requested resource was not found',
          code: 'NOT_FOUND',
          details: data,
          statusCode: statusCode,
          stackTrace: error.stackTrace,
        );

      case 409:
        return BusinessException(
          message: 'Conflict occurred with the current state of the resource',
          code: 'CONFLICT',
          details: data,
          stackTrace: error.stackTrace,
        );

      case 422:
        return ValidationException(
          message: 'Validation failed',
          code: 'UNPROCESSABLE_ENTITY',
          details: data,
          fieldErrors: _extractFieldErrors(data),
          stackTrace: error.stackTrace,
        );

      case 429:
        return NetworkException(
          message: 'Too many requests. Please try again later.',
          code: 'TOO_MANY_REQUESTS',
          details: data,
          statusCode: statusCode,
          stackTrace: error.stackTrace,
        );

      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
        return NetworkException(
          message: 'Server error. Please try again later.',
          code: 'SERVER_ERROR',
          details: data,
          statusCode: statusCode,
          stackTrace: error.stackTrace,
        );

      default:
        return NetworkException(
          message: message,
          code: 'HTTP_ERROR',
          details: data,
          statusCode: statusCode,
          stackTrace: error.stackTrace,
        );
    }
  }

  static Map<String, String>? _extractFieldErrors(dynamic data) {
    if (data == null || data is! Map<String, dynamic>) {
      return null;
    }

    if (data.containsKey('errors') && data['errors'] is Map<String, dynamic>) {
      final errorsMap = data['errors'] as Map<String, dynamic>;
      final fieldErrors = <String, String>{};

      errorsMap.forEach((key, value) {
        if (value is List) {
          fieldErrors[key] = value.first.toString();
        } else if (value is String) {
          fieldErrors[key] = value;
        }
      });

      return fieldErrors;
    }

    return null;
  }
}