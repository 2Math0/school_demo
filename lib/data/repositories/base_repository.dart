import 'package:school_demo/core/services/supabase_service.dart';

abstract class BaseRepository {
  final SupabaseService supabaseService;

  BaseRepository({required this.supabaseService});

  String get userId => supabaseService.client.auth.currentUser?.id ?? '';

  bool get isAuthenticated => supabaseService.client.auth.currentUser != null;
}
