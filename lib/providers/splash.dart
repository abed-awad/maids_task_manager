import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:task_manager/connectors/auth.dart';
import 'package:task_manager/db/local_storage.dart';
import 'package:task_manager/screens/auth/login.dart';
import 'package:task_manager/screens/home/home.dart';
import 'package:task_manager/styles/snackbar.dart';

// Why does the app require login each time it is opened?
// Because if the user is logged in, the app needs to check if the password has been changed by an admin or via email....
// or if the user's information has been updated.

class SplashController extends ChangeNotifier {
  String buildVersion = "";

  void checkUserLogin(BuildContext ctx) async {
    getAppVersion();

    Future.delayed(const Duration(seconds: 2)).then((_) async {
      final isLogin = await LocalStorage.getBoolValue(IS_LOGIN);

      if (isLogin) {
        checkUserPassword(ctx);
      } else {
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    });
  }

  Future<void> checkUserPassword(BuildContext ctx) async {
    try {
      final username = await LocalStorage.getStringValue(USERNAME);
      final password = await LocalStorage.getStringValue(USER_PASSWORD);

      bool isSuccess = await AuthConnector().login(
        ctx,
        username,
        password,
      );
      if (isSuccess) {
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    } catch (e) {
      showErrorSnackBar(ctx, e.toString());
    }
  }

  void getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    buildVersion = packageInfo.version;
  }
}
