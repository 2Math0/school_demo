import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../core/services/api_service.dart';
import '../core/services/supabase_api_service.dart';
import '../core/theme/app_theme.dart';
import '../presentation/cubit/auth/auth_cubit.dart';
import '../presentation/cubit/theme/theme_cubit.dart';
import '../presentation/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => SupabaseApiService(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            apiService: context.read<ApiService>(),
          ),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'School Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            routerConfig: createRouter(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
