import 'package:canteen_app/core/theme/theme.dart';
import 'package:canteen_app/features/presentation/pages/home_page.dart';
import 'package:canteen_app/features/presentation/pages/sign_in_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBAscXzQYYbBIT9USPhhYv8a_9g0Z0EguM",
            authDomain: "canteenapp-9f3bb.firebaseapp.com",
            projectId: "canteenapp-9f3bb",
            storageBucket: "canteenapp-9f3bb.appspot.com",
            messagingSenderId: "936429006771",
            appId: "1:936429006771:web:24373be6e4e6b98a13a5c6",
            measurementId: "G-ZMKCDLXCNW"));
  } else {
    Firebase.initializeApp();
  }

  runApp(
    const MyApp(),
  );
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
      home: const SignInPage(),
    );
  }
}
