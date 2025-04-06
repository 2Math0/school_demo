
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
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// Network related exceptions
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// Database related exceptions
class DatabaseException extends AppException {
  const DatabaseException({
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// Cache related exceptions
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// File related exceptions
class FileException extends AppException {
  const FileException({
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// Validation related exceptions
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// Permission related exceptions
class PermissionException extends AppException {
  const PermissionException({
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// Business logic related exceptions
class BusinessException extends AppException {
  const BusinessException({
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// Timeout related exceptions
class TimeoutException extends AppException {
  const TimeoutException({
    required super.message,
    super.details,
    super.stackTrace,
  });
}

// Unknown/unexpected exceptions
class UnknownException extends AppException {
  const UnknownException({
    required super.message,
    super.details,
    super.stackTrace,
  });
}
