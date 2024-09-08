import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/domain/repository/todo_repo.dart';

class FirebaseTodoRepo implements TodoRepo {
  late FirebaseFirestore firestore;
  late CollectionReference db;
  final String uid;

  FirebaseTodoRepo(this.uid) : super() {
    //
    firestore = FirebaseFirestore.instance;
    db = firestore.collection(uid);
  }

  @override
  Future<void> addTodo(Todo newTodo) async {
    await db.doc(newTodo.id.toString()).set(newTodo.toMap());
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    //
    await db.doc(todo.id.toString()).delete();
  }

  @override
  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    final snapshot = await db.get();
    for (var val in snapshot.docs) {
      todos.add(Todo.fromMap(val.data() as Map<String, dynamic>));
    }
    return todos;
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    //
    await db.doc(todo.id.toString()).update(todo.toMap());
  }
}
