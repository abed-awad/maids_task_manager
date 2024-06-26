import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/styles/color.dart';

class SecondButton extends StatelessWidget {
  final Function() onClick;
  final String text;
  final bool? isSmall;

  const SecondButton({
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
          color: ColorsStyle.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: ColorsStyle.primaryColor,
            width: 1,
          ),
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
            color: ColorsStyle.primaryColor,
            fontSize: isSmall != null && isSmall! ? 14.sp : 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
