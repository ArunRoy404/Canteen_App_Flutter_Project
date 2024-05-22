import 'package:canteen_app/core/theme/theme.dart';
import 'package:canteen_app/features/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Canteen App',
      theme: AppTheme.darkThemeMode,
      home: const SignUpPage(),
    );
  }
}
