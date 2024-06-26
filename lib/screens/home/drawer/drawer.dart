import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/auth.dart';
import 'package:task_manager/providers/splash.dart';
import 'package:task_manager/screens/home/user_todo/todos.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/styles/theme.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsStyle.whiteColor,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: ThemesStyle.gredientColor,
            ),
            child: Center(
              child: Text(
                "Task Manager",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorsStyle.whiteColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 25.sp,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserTodosScreen(),
                  ));
            },
            leading: const Icon(
              Icons.topic_outlined,
              color: ColorsStyle.secondColor,
            ),
            title: Text(
              "User Todos",
              style: TextStyle(
                color: ColorsStyle.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.language,
              color: ColorsStyle.secondColor,
            ),
            title: Text(
              "Change Language (Soon)",
              style: TextStyle(
                color: ColorsStyle.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () => context.read<AuthController>().logout(context),
            leading: const Icon(
              Icons.logout,
              color: ColorsStyle.secondColor,
            ),
            title: Text(
              "Sign out",
              style: TextStyle(
                color: ColorsStyle.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Consumer<SplashController>(
            builder: (context, controller, child) => Align(
              alignment: Alignment.center,
              child: Text(
                "\u00a9 TaskManagerApp v.${controller.buildVersion}",
                style: TextStyle(
                  color: ColorsStyle.primaryColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
