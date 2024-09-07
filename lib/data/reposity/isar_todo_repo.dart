// database repo

// This implements the todo repo and performs curd operations

import 'package:isar/isar.dart';
import 'package:todo/data/models/isar_todo.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  // isar db
  final Isar db;

  IsarTodoRepo(this.db);

  // add todos to isar db
  @override
  Future<void> addTodo(Todo newTodo) async {
    // convert domain todo -->> isar todo
    final todoIsar = TodoIsar.fromDoamin(newTodo);

    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  // delete todo fom db
  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }

  // retrive all todos
  @override
  Future<List<Todo>> getTodos() async {
    // fetch all isar todos form isar db and convert them into domain todos
    final todos = await db.todoIsars.where().findAll();
    return todos.map((e) => e.toDomain()).toList();
  }

  // update todo
  @override
  Future<void> updateTodo(Todo todo) {
    final todoIsar = TodoIsar.fromDoamin(todo);

    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }
}
