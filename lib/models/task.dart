class TaskModel {
  final List<TodoModel> todos;
  final int total;

  TaskModel({
    required this.todos,
    required this.total,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      todos: List<TodoModel>.from(
        (map['todos'] as List).map<TodoModel>(
          (x) => TodoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: map['total'] ?? 0,
    );
  }
}

class TodoModel {
  int id;
  final String todo;
  bool isCompleted;

  TodoModel({
    required this.id,
    required this.todo,
    required this.isCompleted,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] ?? 0,
      todo: map['todo'] ?? "",
      isCompleted: map['completed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'completed': isCompleted ? 1 : 0,
    };
  }

  factory TodoModel.fromMapLocal(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] ?? 0,
      todo: map['todo'] ?? "",
      isCompleted: (map['completed'] ?? 0) == 1,
    );
  }
}
