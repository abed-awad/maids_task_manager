import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/helpers/helper.dart';
import 'package:task_manager/providers/user_todo.dart';
import 'package:task_manager/screens/home/user_todo/widgets/add_todo.dart';
import 'package:task_manager/screens/home/widgets/todo_item.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/styles/snackbar.dart';
import 'package:task_manager/widgets/appbar.dart';
import 'package:task_manager/widgets/custom_safe_area.dart';

class UserTodosScreen extends StatefulWidget {
  const UserTodosScreen({super.key});

  @override
  State<UserTodosScreen> createState() => _UserTodosScreenState();
}

class _UserTodosScreenState extends State<UserTodosScreen> {
  @override
  void initState() {
    final controller = context.read<UserTodoController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getLocalData();
      controller.getData(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Consumer<UserTodoController>(
        builder: (context, controller, child) => Scaffold(
          appBar: customAppbar(title: "User Todos"),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showCustomBottomSheet(context, const AddTodoBottomSheet());
            },
            backgroundColor: ColorsStyle.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.add,
              color: ColorsStyle.whiteColor,
            ),
          ),
          body: controller.todos.isEmpty
              ? Container(
                  margin: EdgeInsets.only(
                    top: deviceHeight(context) * 0.3,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "No todos yet",
                    style: TextStyle(
                      color: ColorsStyle.blackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 10.h,
                  ),
                  itemCount: controller.todos.length,
                  itemBuilder: (context, index) => TodoItemWidget(
                    isUserTask: true,
                    todo: controller.todos[index],
                  ),
                ),
        ),
      ),
    );
  }
}
