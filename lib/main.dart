import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/data/models/isar_todo.dart';
import 'package:todo/data/reposity/isar_todo_repo.dart';
import 'package:todo/domain/repository/todo_repo.dart';
import 'package:todo/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // db path
  final dir = await getApplicationDocumentsDirectory();

  // open isar db
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  // init db
  final isarTodoRepo = IsarTodoRepo(isar);

  runApp(MyApp(todoRepo: isarTodoRepo));
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;
  const MyApp({super.key, required this.todoRepo});
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
      home: TodoPage(todoRepo: todoRepo),
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
