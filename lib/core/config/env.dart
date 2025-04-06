import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  static String get supabaseServiceRoleKey =>
      dotenv.env['SUPABASE_SERVICE_ROLE_KEY'] ?? '';

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
  }

  static bool get isInitialized => dotenv.isInitialized;

  static void validate() {
    assert(supabaseUrl.isNotEmpty, 'SUPABASE_URL is not set in .env file');
    assert(supabaseAnonKey.isNotEmpty,
        'SUPABASE_ANON_KEY is not set in .env file');
    assert(supabaseServiceRoleKey.isNotEmpty,
        'SUPABASE_SERVICE_ROLE_KEY is not set in .env file');
  }
}
