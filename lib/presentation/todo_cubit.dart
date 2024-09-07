// TO DO cubit for state management

// cubit - list of todos

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  // ref to todo repo     (for accessing methods to perform curd)
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  // get all todos
  Future<void> loadTodos() async {
    final todoLsit = await todoRepo.getTodos();

    // emit the fetched list
    emit(todoLsit);
  }

  // add new todo
  Future<void> addTodo(String text) async {
    // create new todo
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    // add to db
    await todoRepo.addTodo(newTodo);

    // reload the todos
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    // delete todo from db(todo repo)
    await todoRepo.deleteTodo(todo);

    // reload
    loadTodos();
  }

  // toggle completion
  Future<void> toggleCompletion(Todo todo) async {
    final uTodo = todo.toggleCompletion();

    // update todo in repo
    await todoRepo.updateTodo(uTodo);

    // reload
    loadTodos();
  }
}
