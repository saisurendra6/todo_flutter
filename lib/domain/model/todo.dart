// TO DO Model

// Properties

// - id
// - text
// - isCompleted

class Todo {
  final int id;
  final String text;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
        id: map['id'], text: map['text'], isCompleted: map['isCompleted']);
  }

  Todo toggleCompletion() {
    return Todo(id: id, text: text, isCompleted: !isCompleted);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isCompleted': isCompleted,
    };
  }
}
