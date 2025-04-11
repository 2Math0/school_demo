import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/api_service.dart';

abstract class BaseRepository {
  final ApiService apiService;
  final SupabaseClient supabaseClient;

  BaseRepository({required this.apiService})
      : supabaseClient = Supabase.instance.client;

  String get userId => supabaseClient.auth.currentUser?.id ?? '';

  bool get isAuthenticated => supabaseClient.auth.currentUser != null;
}
