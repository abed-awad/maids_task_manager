import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/user_todo.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/styles/inputs.dart';
import 'package:task_manager/widgets/loading.dart';
import 'package:task_manager/widgets/primary_button.dart';

class AddTodoBottomSheet extends StatelessWidget {
  const AddTodoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserTodoController>(
      builder: (context, controller, child) => Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add new todo",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: ColorsStyle.blackColor,
                ),
              ),
              SizedBox(height: 20.sp),
              Text(
                "Todo",
                style: TextStyle(
                  color: ColorsStyle.blackColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              TextFormField(
                controller: controller.todoController,
                decoration: InputsStyle.simple(
                  hint: "Note",
                  prefix: const Icon(
                    Icons.edit_outlined,
                    color: ColorsStyle.secondColor,
                  ),
                  hasPadding: true,
                ),
                maxLines: 5,
                style: TextStyle(
                  color: ColorsStyle.blackColor,
                  fontSize: 12.sp,
                ),
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Container(
                    width: 25.w,
                    height: 25.h,
                    color: Colors.transparent,
                    child: Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        side: const BorderSide(
                          color: ColorsStyle.primaryColor,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        activeColor: ColorsStyle.primaryColor,
                        checkColor: ColorsStyle.whiteColor,
                        value: controller.isCompleted,
                        onChanged: (v) {
                          controller.setIsCompleted(v!);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    "Is Completed",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsStyle.blackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              controller.isLoading
                  ? const LoadingWidget()
                  : PrimaryButton(
                      onClick: () => controller.addNewTodo(context),
                      text: "Submit",
                    ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
