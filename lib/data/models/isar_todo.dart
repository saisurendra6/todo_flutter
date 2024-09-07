// ISAR TO DO Model

// todo model <<-->> isar todo model

import 'package:isar/isar.dart';
import 'package:todo/domain/model/todo.dart';

// to generate isar obj,......
// run: dart run build_runner build
part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  // convert isar todo obj -->> pure todo obj
  // pure todo obj is used in our app
  Todo toDomain() {
    return Todo(id: id, text: text, isCompleted: isCompleted);
  }

  // convert pure todo obj -->> isar todo obj
  // isar todo obj is used to store in isar db

  static TodoIsar fromDoamin(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}
