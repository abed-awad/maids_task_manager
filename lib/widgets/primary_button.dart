import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/styles/theme.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onClick;
  final String text;
  final bool? isSmall;

  const PrimaryButton({
    super.key,
    required this.onClick,
    required this.text,
    this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: ThemesStyle.gredientColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: isSmall != null && isSmall! ? 10.w : 20.w,
          vertical: isSmall != null && isSmall! ? 5.h : 10.h,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsStyle.whiteColor,
            fontSize: isSmall != null && isSmall! ? 14.sp : 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
