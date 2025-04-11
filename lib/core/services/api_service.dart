import 'package:dio/dio.dart';
import 'package:school_demo/core/exceptions/app_exception.dart';
import '../../data/models/course.dart';
import '../../data/models/user.dart';

abstract class ApiService {
  // Authentication
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userMetadata,
  });
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<void> resetPassword(String email);

  // User Profile
  Future<User> getUserProfile(String userId);
  Future<User> updateUserProfile(
      String userId, Map<String, dynamic> userMetadata);

  // Courses
  Future<List<Course>> getCourses({
    String? category,
    String? level,
    String? search,
    bool? isFeatured,
    bool? isPopular,
    int? limit,
    int? offset,
  });
  Future<Course> getCourseDetails(String courseId);
  Future<void> enrollInCourse(String courseId);

  // Progress
  Future<Map<String, dynamic>> getCourseProgress(String courseId);
  Future<void> updateCourseProgress(
      String courseId, Map<String, dynamic> progress);

  // Storage
  Future<String> uploadCourseThumbnail(String filePath);
  Future<String> uploadLessonVideo(String filePath);
}

class ApiServiceImpl implements ApiService {
  final Dio _dio;

  ApiServiceImpl({required Dio dio}) : _dio = dio;

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw NetworkException(
        message: 'Failed to get data from $path',
        details: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw NetworkException(
        message: 'Failed to post data to $path',
        details: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw NetworkException(
        message: 'Failed to update data at $path',
        details: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw NetworkException(
        message: 'Failed to delete data at $path',
        details: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  Future<Response> uploadFile(
    String path,
    String filePath, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        ...?data,
      });

      final response = await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response;
    } on DioException catch (e) {
      throw NetworkException(
        message: 'Failed to upload file to $path',
        details: e.message,
        stackTrace: e.stackTrace,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userMetadata,
  }) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<User> getUserProfile(String userId) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<User> updateUserProfile(
      String userId, Map<String, dynamic> userMetadata) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<List<Course>> getCourses({
    String? category,
    String? level,
    String? search,
    bool? isFeatured,
    bool? isPopular,
    int? limit,
    int? offset,
  }) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<Course> getCourseDetails(String courseId) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<void> enrollInCourse(String courseId) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getCourseProgress(String courseId) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<void> updateCourseProgress(
      String courseId, Map<String, dynamic> progress) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<String> uploadCourseThumbnail(String filePath) async {
    // Implementation needed
    throw UnimplementedError();
  }

  @override
  Future<String> uploadLessonVideo(String filePath) async {
    // Implementation needed
    throw UnimplementedError();
  }
}
