import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/providers/user_todo.dart';
import 'package:task_manager/screens/home/widgets/check_button.dart';
import 'package:task_manager/styles/color.dart';

class TodoItemWidget extends StatelessWidget {
  final bool isUserTask;
  final TodoModel todo;

  const TodoItemWidget({
    super.key,
    required this.isUserTask,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: ColorsStyle.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsStyle.greyColor,
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      child: Consumer<UserTodoController>(
        builder: (context, controller, child) => Row(
          children: [
            CheckButton(
              isCheck: todo.isCompleted,
              onChange: !isUserTask
                  ? () {}
                  : () => controller.editTodo(context, todo),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.todo,
                    style: TextStyle(
                      color: ColorsStyle.blackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat("MMM, dd").format(DateTime.now()),
                    style: TextStyle(
                      color: ColorsStyle.greyColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (isUserTask) SizedBox(width: 5.w),
            if (isUserTask)
              InkWell(
                onTap: () => controller.showDeleteDialog(context, todo),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: ColorsStyle.secondColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
