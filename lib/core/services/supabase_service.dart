import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/api_constants.dart';
import '../exceptions/app_exception.dart';

class SupabaseService {
  final SupabaseClient client;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  const SupabaseService({required this.client});

  static Future<void> initialize({
    required String supabaseUrl,
    required String supabaseAnonKey,
  }) async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  // Token management
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  // Auth methods
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: data,
    );
    if (response.session?.accessToken != null) {
      await saveToken(response.session!.accessToken);
    }
    return response;
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.session?.accessToken != null) {
      await saveToken(response.session!.accessToken);
    }
    return response;
  }

  Future<void> signOut() async {
    await client.auth.signOut();
    await deleteToken();
  }

  Future<void> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  Future<void> updatePassword(String newPassword) async {
    await client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  Future<User?> getCurrentUser() async {
    return client.auth.currentUser;
  }

  Future<Session?> getCurrentSession() async {
    return client.auth.currentSession;
  }

  // Storage methods
  Future<String> uploadFileToStorage({
    required String bucket,
    required String path,
    required File file,
  }) async {
    await client.storage.from(bucket).upload(path, file);
    return client.storage.from(bucket).getPublicUrl(path);
  }

  Future<void> deleteFileFromStorage({
    required String bucket,
    required String path,
  }) async {
    await client.storage.from(bucket).remove([path]);
  }

  Future<String> getStoragePublicUrl({
    required String bucket,
    required String path,
  }) async {
    return client.storage.from(bucket).getPublicUrl(path);
  }

  // Database methods
  SupabaseQueryBuilder from(String table) {
    return client.from(table);
  }

  RealtimeChannel channel(String channelName) {
    return client.channel(channelName);
  }

  // Realtime subscription methods
  Stream<List<Map<String, dynamic>>> streamTable(String table) {
    return client.from(table).stream(primaryKey: ['id']).map((event) => event);
  }

  Stream<Map<String, dynamic>> streamRecord(String table, String id) {
    return client
        .from(table)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((event) => event.first);
  }

  // User methods
  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      final response = await client
          .from(ApiConstants.usersTable)
          .select()
          .eq('id', userId)
          .single();
      return response;
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get user data',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  // Course methods
  Future<List<Map<String, dynamic>>> getCourses({
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    try {
      final query = client.from(ApiConstants.coursesTable).select();

      if (orderBy != null) {
        query.order(orderBy, ascending: ascending);
      }

      if (limit != null) {
        query.limit(limit);
      }

      if (offset != null) {
        query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get courses',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<Map<String, dynamic>> getCourse(String id) async {
    try {
      final response = await client
          .from(ApiConstants.coursesTable)
          .select()
          .eq('id', id)
          .single();
      return response;
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get course',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> createCourse(Map<String, dynamic> course) async {
    try {
      await client.from(ApiConstants.coursesTable).insert(course);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to create course',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> updateCourse(String id, Map<String, dynamic> course) async {
    try {
      await client.from(ApiConstants.coursesTable).update(course).eq('id', id);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to update course',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> deleteCourse(String id) async {
    try {
      await client.from(ApiConstants.coursesTable).delete().eq('id', id);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to delete course',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getInstructorCourses(
      String instructorId) async {
    try {
      final response = await client
          .from(ApiConstants.coursesTable)
          .select()
          .eq('instructor_id', instructorId);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get instructor courses',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getStudentCourses(String studentId) async {
    try {
      final response = await client
          .from(ApiConstants.coursesTable)
          .select()
          .eq('student_id', studentId);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get student courses',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> enrollStudent(String courseId, String studentId) async {
    try {
      await client.from(ApiConstants.coursesTable).insert({
        'course_id': courseId,
        'student_id': studentId,
      });
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to enroll student',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> unenrollStudent(String courseId, String studentId) async {
    try {
      await client
          .from(ApiConstants.coursesTable)
          .delete()
          .eq('course_id', courseId)
          .eq('student_id', studentId);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to unenroll student',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  // Progress methods
  Future<Map<String, dynamic>> getProgress(
      String userId, String courseId) async {
    try {
      final response = await client
          .from(ApiConstants.progressTable)
          .select()
          .eq('user_id', userId)
          .eq('course_id', courseId)
          .single();
      return response;
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get progress',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getUserProgress(String userId) async {
    try {
      final response = await client
          .from(ApiConstants.progressTable)
          .select()
          .eq('user_id', userId);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get user progress',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> updateProgress(Map<String, dynamic> progress) async {
    try {
      await client.from(ApiConstants.progressTable).upsert(progress);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to update progress',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> markContentCompleted(
    String userId,
    String courseId,
    String contentId,
  ) async {
    try {
      await client.from(ApiConstants.progressTable).upsert({
        'user_id': userId,
        'course_id': courseId,
        'content_id': contentId,
        'is_completed': true,
        'progress': 100,
        'last_accessed': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to mark content as completed',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> saveQuizResult(
    String userId,
    String courseId,
    String contentId,
    List<Map<String, dynamic>> results,
  ) async {
    try {
      await client.from(ApiConstants.progressTable).upsert({
        'user_id': userId,
        'course_id': courseId,
        'content_id': contentId,
        'quiz_results': results,
        'last_accessed': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to save quiz results',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<double> getCourseProgress(String userId, String courseId) async {
    try {
      final response = await client
          .from(ApiConstants.progressTable)
          .select('progress')
          .eq('user_id', userId)
          .eq('course_id', courseId)
          .single();
      return (response['progress'] as num).toDouble();
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get course progress',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<Map<String, double>> getOverallProgress(String userId) async {
    try {
      final response = await client
          .from(ApiConstants.progressTable)
          .select('course_id, progress')
          .eq('user_id', userId);
      final Map<String, double> progress = {};
      for (final item in response) {
        progress[item['course_id'] as String] =
            (item['progress'] as num).toDouble();
      }
      return progress;
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get overall progress',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  // Chat methods
  Future<List<Map<String, dynamic>>> getChatHistory(String userId) async {
    try {
      final response = await client
          .from(ApiConstants.chatMessagesTable)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get chat history',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> sendMessage(Map<String, dynamic> message) async {
    try {
      await client.from(ApiConstants.chatMessagesTable).insert(message);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to send message',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> deleteMessage(String messageId) async {
    try {
      await client
          .from(ApiConstants.chatMessagesTable)
          .delete()
          .eq('id', messageId);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to delete message',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> clearChatHistory(String userId) async {
    try {
      await client
          .from(ApiConstants.chatMessagesTable)
          .delete()
          .eq('user_id', userId);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to clear chat history',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getRecentMessages(String userId) async {
    try {
      final response = await client
          .from(ApiConstants.chatMessagesTable)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(10);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get recent messages',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> markMessageAsRead(String messageId) async {
    try {
      await client
          .from(ApiConstants.chatMessagesTable)
          .update({'is_read': true}).eq('id', messageId);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to mark message as read',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  // File upload methods
  Future<String> uploadFile(
    String bucket,
    String path,
    Uint8List fileBytes, {
    String? contentType,
  }) async {
    try {
      final response = await client.storage.from(bucket).uploadBinary(
            path,
            fileBytes,
            fileOptions: FileOptions(
              contentType: contentType,
            ),
          );
      return response;
    } catch (e) {
      throw FileException(
        message: 'Failed to upload file',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<String> getFileUrl(String bucket, String path) async {
    try {
      return client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      throw FileException(
        message: 'Failed to get file URL',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }
}
