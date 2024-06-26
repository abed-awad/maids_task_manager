import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/helpers/helper.dart';
import 'package:task_manager/providers/home.dart';
import 'package:task_manager/screens/home/drawer/drawer.dart';
import 'package:task_manager/screens/home/widgets/header.dart';
import 'package:task_manager/screens/home/widgets/todo_item.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/widgets/custom_safe_area.dart';
import 'package:task_manager/widgets/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;

  @override
  void initState() {
    controller = context.read<HomeController>();

    controller.scrollController.addListener(() {
      if (controller.scrollController.offset >=
              controller.scrollController.position.maxScrollExtent &&
          !controller.scrollController.position.outOfRange) {
        controller.getData();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => controller.showExitDialog(context),
      child: CustomSafeArea(
        child: Scaffold(
          key: controller.scaffoldKey,
          endDrawer: const DrawerWidget(),
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
              () => controller.refreshData(),
            ),
            color: ColorsStyle.primaryColor,
            backgroundColor: ColorsStyle.whiteColor,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller.scrollController,
              padding: EdgeInsets.only(bottom: 20.h),
              children: [
                const HeaderHomeWidget(),
                Consumer<HomeController>(
                  builder: (context, controller, child) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Users Todos (Pagination)",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsStyle.blackColor,
                          ),
                        ),
                        Text(
                          controller.totalTodos.toString(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsStyle.secondColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Consumer<HomeController>(
                  builder: (context, controller, child) =>
                      controller.todos.isEmpty
                          ? controller.hasMore
                              ? const LoadingWidget()
                              : Container(
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
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 5.h,
                              ),
                              itemCount: controller.todos.length + 1,
                              itemBuilder: (context, index) {
                                if (index < controller.todos.length) {
                                  return TodoItemWidget(
                                    isUserTask: false,
                                    todo: controller.todos[index],
                                  );
                                } else {
                                  return controller.hasMore
                                      ? const LoadingWidget()
                                      : const SizedBox();
                                }
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
