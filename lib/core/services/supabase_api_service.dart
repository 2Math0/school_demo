import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/constants.dart';
import 'api_service.dart';
import '../../data/models/course.dart';
import '../../data/models/user.dart' as models;

class SupabaseApiService implements ApiService {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userMetadata,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: userMetadata,
    );
    return {
      'user': response.user?.toJson(),
      'session': response.session?.toJson(),
    };
  }

  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return {
      'user': response.user?.toJson(),
      'session': response.session?.toJson(),
    };
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Future<models.User> getUserProfile(String userId) async {
    final response = await _supabase
        .from(AppConstants.usersTable)
        .select()
        .eq('id', userId)
        .single();
    return models.User.fromJson(response);
  }

  @override
  Future<models.User> updateUserProfile(
      String userId, Map<String, dynamic> userMetadata) async {
    final response = await _supabase
        .from(AppConstants.usersTable)
        .update(userMetadata)
        .eq('id', userId)
        .select()
        .single();
    return models.User.fromJson(response);
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
    var query = _supabase.from(AppConstants.coursesTable).select();

    if (category != null) {
      query = query.eq('category', category) as dynamic;
    }
    if (level != null) {
      query = query.eq('level', level) as dynamic;
    }
    if (search != null) {
      query = query.ilike('title', '%$search%') as dynamic;
    }
    if (isFeatured != null) {
      query = query.eq('is_featured', isFeatured) as dynamic;
    }
    if (isPopular != null) {
      query = query.eq('is_popular', isPopular) as dynamic;
    }
    if (limit != null) {
      query = query.limit(limit) as dynamic;
    }
    if (offset != null) {
      query = query.range(offset, offset + (limit ?? 10) - 1) as dynamic;
    }

    final response = await query;
    return response.map((json) => Course.fromJson(json)).toList();
  }

  @override
  Future<Course> getCourseDetails(String courseId) async {
    final response = await _supabase
        .from(AppConstants.coursesTable)
        .select()
        .eq('id', courseId)
        .single();
    return Course.fromJson(response);
  }

  @override
  Future<void> enrollInCourse(String courseId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _supabase.from(AppConstants.enrollmentsTable).insert({
      'user_id': userId,
      'course_id': courseId,
      'enrolled_at': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<Map<String, dynamic>> getCourseProgress(String courseId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _supabase
        .from(AppConstants.progressTable)
        .select()
        .eq('user_id', userId)
        .eq('course_id', courseId)
        .single();
    return response;
  }

  @override
  Future<void> updateCourseProgress(
      String courseId, Map<String, dynamic> progress) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _supabase.from(AppConstants.progressTable).upsert({
      'user_id': userId,
      'course_id': courseId,
      ...progress,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<String> uploadCourseThumbnail(String filePath) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final fileName =
        'thumbnails/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final file = File(filePath);
    await _supabase.storage
        .from(AppConstants.storageBucket)
        .upload(fileName, file);
    return _supabase.storage
        .from(AppConstants.storageBucket)
        .getPublicUrl(fileName);
  }

  @override
  Future<String> uploadLessonVideo(String filePath) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    final fileName =
        'videos/$userId/${DateTime.now().millisecondsSinceEpoch}.mp4';
    final file = File(filePath);
    await _supabase.storage
        .from(AppConstants.storageBucket)
        .upload(fileName, file);
    return _supabase.storage
        .from(AppConstants.storageBucket)
        .getPublicUrl(fileName);
  }
}
