import '../config/constants.dart';
import 'api_service.dart';
import 'mock_api_service.dart';
import 'supabase_api_service.dart';

class ApiServiceFactory {
  static ApiService create() {
    return AppConstants.useMockData ? MockApiService() : SupabaseApiService();
  }
}
