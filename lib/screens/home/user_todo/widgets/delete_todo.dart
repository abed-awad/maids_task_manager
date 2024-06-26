import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/providers/user_todo.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/widgets/loading.dart';

class DeleteTodoDialog extends StatelessWidget {
  final TodoModel todo;

  const DeleteTodoDialog({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Are you sure",
        style: TextStyle(
          color: ColorsStyle.blackColor,
          fontSize: 16.sp,
        ),
      ),
      content: Text(
        "You want to delete this todo?",
        style: TextStyle(
          color: ColorsStyle.blackColor,
          fontSize: 14.sp,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text(
            "No",
            style: TextStyle(
              color: ColorsStyle.primaryColor,
              fontSize: 12.sp,
            ),
          ),
        ),
        Consumer<UserTodoController>(
          builder: (context, controller, child) => controller.isLoading
              ? const LoadingWidget()
              : TextButton(
                  onPressed: () {
                    controller.deleteTodo(context, todo);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: ColorsStyle.primaryColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
