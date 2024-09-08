import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/reposity/firebase_todo_repo.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/presentation/auth_page.dart';
import 'package:todo/presentation/todo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final auth = FirebaseAuth.instance;

  runApp(MyApp(auth: auth));
}

class MyApp extends StatelessWidget {
  final FirebaseAuth auth;
  const MyApp({super.key, required this.auth});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log("MyApp auth:  ${auth.currentUser}");
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (auth.currentUser != null)
          ? TodoPage(todoRepo: FirebaseTodoRepo(auth.currentUser!.uid))
          : const AuthPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int val = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("data: $val"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          val++;
        },
        child: const CircleAvatar(
          child: Icon(Icons.plus_one),
        ),
      ),
    );
  }
}
