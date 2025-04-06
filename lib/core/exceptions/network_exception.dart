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
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.sendTimeout:
        return TimeoutException(
          message: 'Request timeout. Please try again later.',
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Server response timeout. Please try again later.',
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Invalid SSL certificate. Please try again later.',
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'Connection error. Please check your internet connection.',
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return NetworkException(
          message: 'Request was cancelled',
          details: error.message,
          stackTrace: error.stackTrace,
        );

      case DioExceptionType.unknown:
      default:
        return NetworkException(
          message: 'Network error occurred',
          details: error.message,
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
          details: data,
          stackTrace: error.stackTrace,
        );

      case 401:
        return AuthException(
          message: 'Unauthorized. Please login again.',
          details: data,
          stackTrace: error.stackTrace,
        );

      case 403:
        return PermissionException(
          message: 'You do not have permission to access this resource',
          details: data,
          stackTrace: error.stackTrace,
        );

      case 404:
        return NetworkException(
          message: 'The requested resource was not found',
          details: data,
          stackTrace: error.stackTrace,
        );

      case 409:
        return BusinessException(
          message: 'Conflict occurred with the current state of the resource',
          details: data,
          stackTrace: error.stackTrace,
        );

      case 422:
        return ValidationException(
          message: 'Validation failed',
          details: data,
          stackTrace: error.stackTrace,
        );

      case 429:
        return NetworkException(
          message: 'Too many requests. Please try again later.',
          details: data,
          stackTrace: error.stackTrace,
        );

      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
        return NetworkException(
          message: 'Server error. Please try again later.',
          details: data,
          stackTrace: error.stackTrace,
        );

      default:
        return NetworkException(
          message: message,
          details: data,
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