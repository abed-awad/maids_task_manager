import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/styles/color.dart';

void showErrorSnackBar(BuildContext ctx, String message) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      backgroundColor: ColorsStyle.redColor,
      content: Text(
        message,
        style: const TextStyle(
          color: ColorsStyle.whiteColor,
        ),
      ),
    ),
  );
}

void showSuccessSnackBar(BuildContext ctx, String message) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      backgroundColor: ColorsStyle.greenColor,
      content: Text(
        message,
        style: const TextStyle(
          color: ColorsStyle.whiteColor,
        ),
      ),
    ),
  );
}

void showCustomBottomSheet(BuildContext ctx, Widget child) {
  showModalBottomSheet(
    context: ctx,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.w,
            height: 5.h,
            margin: EdgeInsets.symmetric(vertical: 15.h),
            decoration: BoxDecoration(
              color: ColorsStyle.lightGreyColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child,
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.r),
        topRight: Radius.circular(10.r),
      ),
    ),
    backgroundColor: ColorsStyle.whiteColor,
    isScrollControlled: true,
    useSafeArea: true,
  );
}
