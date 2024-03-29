import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/auth/auth_console.dart';
import 'package:project_showcase/main_pages/main_page.dart';

class AuthState extends StatelessWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const AuthConsole();
          }
        },
      ),
    );
  }
}
