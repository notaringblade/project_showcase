import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/auth/auth_state.dart';
import 'package:project_showcase/firebase_options.dart';
import 'package:project_showcase/themes/dark_theme.dart';
import 'package:project_showcase/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      // themeMode: ThemeMode.dark,
      //
      home: const AuthState(),
    );
  }
}
