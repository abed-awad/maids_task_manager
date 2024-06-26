import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/apis/api.dart';
import 'package:task_manager/apis/urls.dart';
import 'package:task_manager/db/local_storage.dart';
import 'package:task_manager/models/user.dart';
import 'package:task_manager/providers/auth.dart';
import 'package:task_manager/styles/snackbar.dart';

class AuthConnector {
  Future<bool> login(BuildContext ctx, String username, String password) async {
    bool isSuccess = false;

    final body = {
      'username': username,
      'password': password,
    };

    final apiService = await ApiService.create();
    final response = await apiService.postApi(
      url: LOGIN_URL,
      body: body,
    );

    if (response != null) {
      final res = response.data;

      if (response.statusCode == 200) {
        isSuccess = true;

        final user = UserModel.fromMap(res);
        ctx.read<AuthController>().user = user;

        await LocalStorage.setBoolValue(IS_LOGIN, true);
        await LocalStorage.setStringValue(USERNAME, user.username);
        await LocalStorage.setStringValue(USER_TOKEN, user.token);
        await LocalStorage.setStringValue(USER_PASSWORD, password);
      } else {
        showErrorSnackBar(ctx, res['message'] ?? "Error");
      }
    }

    return isSuccess;
  }
}
