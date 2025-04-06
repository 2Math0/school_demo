// Base exception class for the application
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.details,
    this.stackTrace,
  });

  @override
  String toString() {
    String result = 'AppException: $message';
    if (code != null) result += ' (code: $code)';
    if (details != null) result += '\nDetails: $details';
    if (stackTrace != null) result += '\n$stackTrace';
    return result;
  }
}

// Authentication related exceptions
class AuthException extends AppException {
  const AuthException({
    required String message,
    String? code,
    dynamic details,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    details: details,
    stackTrace: stackTrace,
  );
}

// Network related exceptions
class NetworkException extends AppException {
  final int? statusCode;

  const NetworkException({
    required String message,
    this.statusCode,
    String? code,
    dynamic details,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    details: details,
    stackTrace: stackTrace,
  );
}

// Database related exceptions
class DatabaseException extends AppException {
  const DatabaseException({
    required String message,
    String? code,
    dynamic details,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    details: details,
    stackTrace: stackTrace,
  );
}

// Cache related exceptions
class CacheException extends AppException {
  const CacheException({
    required String message,
    String? code,
    dynamic details,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    details: details,
    stackTrace: stackTrace,
  );
}

// File related exceptions
class FileException extends AppException {
  const FileException({
    required String message,
    String? code,
    dynamic details,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    details: details,
    stackTrace: stackTrace,
  );
}

// Validation related exceptions
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required String message,
    this.fieldErrors,
    String? code,
    dynamic details,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    details: details,
    stackTrace: stackTrace,
  );
}

// Permission related exceptions
class PermissionException extends AppException {
  const PermissionException({
    required String message,
    String? code,
    dynamic details,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    details: details,
    stackTrace: stackTrace,
  );
}

// Business logic related exceptions
class BusinessException extends AppException {
  const BusinessException({
    required String message,
    String? code,
    dynamic details,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    details: details,
    stackTrace: stackTrace,
  );
}

// Timeout related exceptions
class TimeoutException extends AppException {
  const TimeoutException({
    required String message,
    String? code,
    dynamic details,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    details: details,
    stackTrace: stackTrace,
  );
}

// Unknown/unexpected exceptions
class UnknownException extends AppException {
  const UnknownException({
    required String message,
    String? code,
    dynamic details,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code,
    details: details,
    stackTrace: stackTrace,
  );
}