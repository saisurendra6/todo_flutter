import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/main.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: FutureBuilder(
        future: login(),
        builder: (context, s) {
          log(s.toString());
          if (s.data != null) {
            main();
          }
          return const Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text("Login..."),
            ],
          ));
        },
      ),
    );
  }

  Future<User?> login() async {
    final auth = FirebaseAuth.instance;
    await auth.signInAnonymously();
    return auth.currentUser;
  }
}
