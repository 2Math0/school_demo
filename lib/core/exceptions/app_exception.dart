import 'package:equatable/equatable.dart';

// Base exception class for the application
class AppException implements Exception {
  final String message;
  final String? details;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.details,
    this.stackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer(message);
    if (details != null) {
      buffer.write('\nDetails: $details');
    }
    if (stackTrace != null) {
      buffer.write('\nStackTrace: $stackTrace');
    }
    return buffer.toString();
  }
}

// Authentication related exceptions
class AuthException extends AppException {
  const AuthException({
    required String message,
    String? details,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          details: details,
          stackTrace: stackTrace,
        );
}

// Network related exceptions
class NetworkException extends AppException {
  const NetworkException({
    required String message,
    String? details,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          details: details,
          stackTrace: stackTrace,
        );
}

// Database related exceptions
class DatabaseException extends AppException {
  const DatabaseException({
    required String message,
    String? details,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          details: details,
          stackTrace: stackTrace,
        );
}

// Cache related exceptions
class CacheException extends AppException {
  const CacheException({
    required String message,
    String? details,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          details: details,
          stackTrace: stackTrace,
        );
}

// File related exceptions
class FileException extends AppException {
  const FileException({
    required String message,
    String? details,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          details: details,
          stackTrace: stackTrace,
        );
}

// Validation related exceptions
class ValidationException extends AppException {
  const ValidationException({
    required String message,
    String? details,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          details: details,
          stackTrace: stackTrace,
        );
}

// Permission related exceptions
class PermissionException extends AppException {
  const PermissionException({
    required String message,
    String? details,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          details: details,
          stackTrace: stackTrace,
        );
}

// Business logic related exceptions
class BusinessException extends AppException {
  const BusinessException({
    required String message,
    String? details,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          details: details,
          stackTrace: stackTrace,
        );
}

// Timeout related exceptions
class TimeoutException extends AppException {
  const TimeoutException({
    required String message,
    String? details,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          details: details,
          stackTrace: stackTrace,
        );
}

// Unknown/unexpected exceptions
class UnknownException extends AppException {
  const UnknownException({
    required String message,
    String? details,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          details: details,
          stackTrace: stackTrace,
        );
}
