import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/api_constants.dart';
import '../exceptions/app_exception.dart';

class SupabaseService {
  late SupabaseClient _client;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Singleton pattern
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() => _instance;

  SupabaseService._internal();

  Future<void> initialize() async {
    _client = Supabase.instance.client;
  }

  SupabaseClient get client => _client;

  // Auth methods
  Future<User?> getCurrentUser() async {
    try {
      return _client.auth.currentUser;
    } catch (e) {
      throw AuthException(
        message: 'Failed to get current user',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? userData,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: userData,
      );

      if (response.user != null) {
        // Store user data in the database
        await _client.from(ApiConstants.usersTable).insert({
          'id': response.user!.id,
          'email': email,
          'role': 'student', // Default role
          'created_at': DateTime.now().toIso8601String(),
          ...?userData,
        });
      }

      return response;
    } catch (e) {
      throw AuthException(
        message: 'Failed to sign up',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Store session token securely
      if (response.session != null) {
        await _secureStorage.write(
          key: 'supabase_session',
          value: response.session!.persistSessionString,
        );
      }

      return response;
    } catch (e) {
      throw AuthException(
        message: 'Failed to sign in',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
      await _secureStorage.delete(key: 'supabase_session');
    } catch (e) {
      throw AuthException(
        message: 'Failed to sign out',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw AuthException(
        message: 'Failed to reset password',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  // Database methods
  Future<List<Map<String, dynamic>>> getRecords({
    required String table,
    int? limit,
    int? offset,
    String? orderBy,
    bool ascending = false,
    Map<String, dynamic>? filters,
  }) async {
    try {
      var query = _client.from(table).select();

      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      if (offset != null) {
        query = query.range(offset, offset + (limit ?? 10) - 1);
      }

      final response = await query;
      return response;
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get records from $table',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<Map<String, dynamic>> getRecordById({
    required String table,
    required String id,
    String idField = 'id',
  }) async {
    try {
      final response = await _client
          .from(table)
          .select()
          .eq(idField, id)
          .single();

      return response;
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to get record by ID from $table',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<Map<String, dynamic>> insertRecord({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _client
          .from(table)
          .insert(data)
          .select()
          .single();

      return response;
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to insert record into $table',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<Map<String, dynamic>> updateRecord({
    required String table,
    required String id,
    required Map<String, dynamic> data,
    String idField = 'id',
  }) async {
    try {
      final response = await _client
          .from(table)
          .update(data)
          .eq(idField, id)
          .select()
          .single();

      return response;
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to update record in $table',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<void> deleteRecord({
    required String table,
    required String id,
    String idField = 'id',
  }) async {
    try {
      await _client
          .from(table)
          .delete()
          .eq(idField, id);
    } catch (e) {
      throw DatabaseException(
        message: 'Failed to delete record from $table',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  // Storage methods
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required List<int> fileBytes,
    String? contentType,
  }) async {
    try {
      final response = await _client
          .storage
          .from(bucket)
          .uploadBinary(
        path,
        fileBytes,
        fileOptions: FileOptions(
          contentType: contentType,
        ),
      );

      return response;
    } catch (e) {
      throw FileException(
        message: 'Failed to upload file to $bucket',
        details: e.toString(),
        stackTrace: StackTrace.current,
      );
    }
  }

  Future<String> getPublicUrl({
    required String bucket,
    required String path,
  }) async {
    try {
      return _client
          .storage
          .from(bucket)
          .getPublicUrl(path);
    }