import 'package:flutter/material.dart';
import 'package:task_manager/connectors/auth.dart';
import 'package:task_manager/db/local_storage.dart';
import 'package:task_manager/models/user.dart';
import 'package:task_manager/screens/auth/login.dart';
import 'package:task_manager/screens/home/home.dart';

class AuthController extends ChangeNotifier {
  late UserModel user;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isHidePassword = true;
  bool isLoading = false;

  final authConnector = AuthConnector();

  String username = "";
  String password = "";

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setHidePassword(bool value) {
    isHidePassword = value;
    notifyListeners();
  }

  void submit(BuildContext ctx) async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    FocusScope.of(ctx).unfocus();
    formKey.currentState!.save();

    _setLoading(true);
    final isSuccess = await authConnector.login(
      ctx,
      username,
      password,
    );
    _setLoading(false);

    if (isSuccess) {
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  Future<void> logout(BuildContext ctx) async {
    await LocalStorage.clearAllData();

    Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
