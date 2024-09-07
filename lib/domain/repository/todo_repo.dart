import 'package:todo/domain/model/todo.dart';

abstract class TodoRepo {
  // CURD operations

  // get todo list
  Future<List<Todo>> getTodos();

  // add new todo
  Future<void> addTodo(Todo newTodo);

  // update Todo
  Future<void> updateTodo(Todo todo);

  // del todo
  Future<void> deleteTodo(Todo todo);
}
