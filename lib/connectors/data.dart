import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/apis/api.dart';
import 'package:task_manager/apis/urls.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/providers/auth.dart';
import 'package:task_manager/styles/snackbar.dart';

class DataConnector {
  Future<TaskModel> getAllTodos(int skip, int limit) async {
    TaskModel data = TaskModel(
      todos: [],
      total: 0,
    );

    final params = {
      'skip': skip,
      'limit': limit,
    };

    final apiService = await ApiService.create();
    final response = await apiService.getApi(
      url: GET_ALL_TODOS_URL,
      params: params,
    );

    if (response != null) {
      if (response.statusCode == 200) {
        final res = response.data;
        data = TaskModel.fromMap(res);
      }
    }

    return data;
  }

  Future<TaskModel> getUserTodos(BuildContext ctx) async {
    TaskModel data = TaskModel(
      todos: [],
      total: 0,
    );

    final id = ctx.read<AuthController>().user.id;

    final apiService = await ApiService.create();
    final response = await apiService.getApi(
      url: "$GET_USER_TODOS_URL/$id",
    );

    if (response != null) {
      if (response.statusCode == 200) {
        final res = response.data;
        data = TaskModel.fromMap(res);
      }
    }

    return data;
  }

  Future<int> createNewTodo(BuildContext ctx, TodoModel t) async {
    int id = 0;

    final userId = ctx.read<AuthController>().user.id;

    final body = {
      "todo": t.todo,
      "completed": t.isCompleted,
      "userId": userId,
    };

    final apiService = await ApiService.create();
    final response = await apiService.postApi(
      url: ADD_TODO_URL,
      body: body,
    );

    if (response != null) {
      final res = response.data;

      id = res['id'] ?? 0;
    }

    return id;
  }

  Future<bool> editTodo(BuildContext ctx, TodoModel t) async {
    bool isSuccess = false;

    final body = {
      "completed": t.isCompleted,
    };

    final apiService = await ApiService.create();
    final response = await apiService.putApi(
      url: "$EDIT_TODO_URL/${t.id}",
      body: body,
    );

    if (response != null) {
      final res = response.data;
      final data = int.parse((res['id'] ?? 0).toString());
      if (data > 0) {
        isSuccess = true;
      } else {
        showErrorSnackBar(ctx, res['message'] ?? "Error");
      }
    }

    return isSuccess;
  }

  Future<bool> deleteTodo(BuildContext ctx, TodoModel t) async {
    bool isSuccess = false;

    final apiService = await ApiService.create();
    final response = await apiService.deleteApi(
      url: "$DELETE_TODO_URL/${t.id}",
    );

    if (response != null) {
      final res = response.data;
      if (res['isDeleted'] ?? false) {
        isSuccess = true;
      } else {
        showErrorSnackBar(ctx, res['message'] ?? "Error");
      }
    }

    return isSuccess;
  }
}
