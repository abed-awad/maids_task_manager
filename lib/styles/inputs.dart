import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/styles/color.dart';

class InputsStyle {
  static InputDecoration simple({
    required String hint,
    Widget? prefix,
    Widget? suffix,
    bool? hasPadding,
    Color? color,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: color ?? ColorsStyle.inputColor,
      suffixIcon: suffix,
      prefixIcon: prefix,
      hintText: hint,
      isDense: true,
      contentPadding: hasPadding != null && hasPadding
          ? const EdgeInsets.fromLTRB(12, 10, 12, 10)
          : EdgeInsets.zero,
      hintStyle: TextStyle(
        color: ColorsStyle.greyColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
