import 'package:flutter/material.dart';
import 'package:task_manager/connectors/data.dart';
import 'package:task_manager/db/sqflite.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/screens/home/user_todo/widgets/delete_todo.dart';
import 'package:task_manager/styles/snackbar.dart';

class UserTodoController extends ChangeNotifier {
  final todoController = TextEditingController();
  bool isCompleted = false;
  bool isLoading = false;

  List<TodoModel> todos = [];

  final dataConnector = DataConnector();
  final _dbService = SQFLiteDatabaseService();

  Future<void> getLocalData() async {
    todos = await _dbService.getTodos();
    notifyListeners();
  }

  void getData(BuildContext ctx) async {
    final data = await dataConnector.getUserTodos(ctx);
    todos = data.todos;
    await _dbService.insertAllTodos(todos);
    notifyListeners();
  }

  void addNewTodo(BuildContext ctx) async {
    if (todoController.text.isEmpty) {
      return null;
    }

    final newTodo = TodoModel(
      id: 0,
      todo: todoController.text,
      isCompleted: isCompleted,
    );

    _setLoading(true);
    final newId = await dataConnector.createNewTodo(ctx, newTodo);
    _setLoading(false);

    if (newId > 0) {
      newTodo.id = newId;
      todos.add(newTodo);
      notifyListeners();

      _dbService.insertTodo(newTodo);

      Navigator.pop(ctx);
      showSuccessSnackBar(ctx, "New todo has been added successfully");
      clearAddData();
    }
  }

  void clearAddData() {
    todoController.clear();
    isCompleted = false;
  }

  void editTodo(BuildContext ctx, TodoModel todo) async {
    final t = todos.firstWhere((e) => e.id == todo.id);
    t.isCompleted = !t.isCompleted;
    notifyListeners();

    _setLoading(true);
    final isSuccess = await dataConnector.editTodo(ctx, todo);
    _setLoading(false);

    if (isSuccess) {
      _dbService.updateTodo(t);
    } else {
      final t = todos.firstWhere((e) => e.id == todo.id);
      t.isCompleted = !t.isCompleted;
      notifyListeners();
    }
  }

  void deleteTodo(BuildContext ctx, TodoModel todo) async {
    _setLoading(true);
    final isSuccess = await dataConnector.deleteTodo(ctx, todo);
    _setLoading(false);

    if (isSuccess) {
      todos.removeWhere((e) => e.id == todo.id);
      notifyListeners();

      _dbService.deleteTodo(todo.id);

      Navigator.pop(ctx);
      showSuccessSnackBar(
        ctx,
        "Success, This todo has been deleted successfully",
      );
    }
  }

  void showDeleteDialog(BuildContext ctx, TodoModel todo) {
    showDialog(
      context: ctx,
      builder: (context) => DeleteTodoDialog(todo: todo),
    );
  }

  void setIsCompleted(bool value) {
    isCompleted = value;
    notifyListeners();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }
}
