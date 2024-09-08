// TO DO VIEW - resposible for UI

// - uses BlocBuilder

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        centerTitle: true,
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(builder: (context, todos) {
        return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, i) {
              final todo = todos[i];
              return ListTile(
                // text title
                title: Text(todo.text,
                    style: todo.isCompleted
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 20)
                        : const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                // check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (val) => todoCubit.toggleCompletion(todo),
                ),
                // del icon
                trailing: IconButton(
                  onPressed: () => todoCubit.deleteTodo(todo),
                  icon: const Icon(Icons.delete_rounded),
                  highlightColor: Colors.red.withOpacity(0.4),
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTodoDialog(context),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.add_task_rounded),
        title: const Text("Enter new item"),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          // cancel btn
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          // add btn
          TextButton(
            onPressed: () {
              todoCubit.addTodo(textController.text);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
