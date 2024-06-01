import 'package:canteen_app/core/secrets/app_secrets.dart';
import 'package:canteen_app/core/theme/theme.dart';
import 'package:canteen_app/features/data/data_resources/auth_remote_data_source.dart';
import 'package:canteen_app/features/data/repositories/auth_repository_impl.dart';
import 'package:canteen_app/features/domain/Repository/usecases/user_sign_up.dart';
import 'package:canteen_app/features/presentation/bloc/auth_bloc.dart';
import 'package:canteen_app/features/presentation/pages/home_page.dart';
import 'package:canteen_app/features/presentation/pages/sign_in_page.dart';
import 'package:canteen_app/features/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            AuthRepositoryImpl(
              AuthRemotedataSourceImpl(
                supabase.client,
              ),
            ),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Canteen App',
      theme: AppTheme.lightThemeMode,
      home: const HomePage(),
    );
  }
}
