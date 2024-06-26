import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/styles/theme.dart';

AppBar customAppbar({required String title, List<Widget>? actions}) {
  return AppBar(
    iconTheme: const IconThemeData(color: ColorsStyle.whiteColor),
    flexibleSpace: Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: ThemesStyle.gredientColor,
      ),
    ),
    centerTitle: false,
    title: Text(
      title,
      style: TextStyle(
        color: ColorsStyle.whiteColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
    actions: actions,
  );
}
