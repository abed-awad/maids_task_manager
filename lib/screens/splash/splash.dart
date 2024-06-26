import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/helpers/helper.dart';
import 'package:task_manager/providers/splash.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/styles/theme.dart';
import 'package:task_manager/widgets/custom_safe_area.dart';
import 'package:task_manager/widgets/loading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final controller = context.read<SplashController>();
    controller.checkUserLogin(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Center(
            child: Text(
              "Task Manager App",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 0,
                color: ColorsStyle.blackColor,
                fontWeight: FontWeight.w900,
                fontSize: 40.sp,
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: deviceHeight(context) * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(70.r),
              topRight: Radius.circular(70.r),
            ),
            gradient: ThemesStyle.gredientColor,
          ),
          alignment: Alignment.center,
          child: const LoadingWidget(
            size: 100,
            color: ColorsStyle.whiteColor,
          ),
        ),
      ),
    );
  }
}
