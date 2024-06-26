import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/helpers/helper.dart';
import 'package:task_manager/helpers/icon_path.dart';
import 'package:task_manager/helpers/validations.dart';
import 'package:task_manager/providers/auth.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/styles/inputs.dart';
import 'package:task_manager/styles/theme.dart';
import 'package:task_manager/widgets/custom_safe_area.dart';
import 'package:task_manager/widgets/loading.dart';
import 'package:task_manager/widgets/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthController>();

    return CustomSafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: deviceHeight(context),
              decoration: const BoxDecoration(
                gradient: ThemesStyle.gredientColor,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 30.h,
              ),
              child: Text(
                "Welcome\nback!",
                style: TextStyle(
                  fontSize: 40.sp,
                  height: 1.1,
                  fontWeight: FontWeight.bold,
                  color: ColorsStyle.whiteColor,
                ),
              ),
            ),
            Container(
              height: deviceHeight(context) * 0.8,
              margin: EdgeInsets.only(top: deviceHeight(context) * 0.2),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsStyle.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: 20.h,
                ),
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign In",
                          style: TextStyle(
                            color: ColorsStyle.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          "Username",
                          style: TextStyle(
                            color: ColorsStyle.primaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        TextFormField(
                          decoration: InputsStyle.simple(
                            hint: "Name",
                            prefix: const Icon(
                              Icons.person,
                              color: ColorsStyle.secondColor,
                            ),
                          ),
                          style: TextStyle(
                            color: ColorsStyle.blackColor,
                            fontSize: 12.sp,
                          ),
                          validator: (value) => validateInput(value!),
                          textInputAction: TextInputAction.next,
                          onSaved: (newValue) =>
                              controller.username = newValue!,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Password",
                          style: TextStyle(
                            color: ColorsStyle.primaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Consumer<AuthController>(
                          builder: (context, controller, child) =>
                              TextFormField(
                            decoration: InputsStyle.simple(
                              hint: "Password",
                              prefix: const Icon(
                                Icons.vpn_key,
                                color: ColorsStyle.secondColor,
                              ),
                              suffix: IconButton(
                                onPressed: () => controller.setHidePassword(
                                  !controller.isHidePassword,
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SvgPicture.asset(
                                    controller.isHidePassword
                                        ? IconsPathHelper.eyeClose
                                        : IconsPathHelper.eyeOpen,
                                    colorFilter: const ColorFilter.mode(
                                      ColorsStyle.blackColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: ColorsStyle.blackColor,
                              fontSize: 12.sp,
                            ),
                            obscureText: controller.isHidePassword,
                            validator: (value) => validateInput(value!),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            onSaved: (newValue) =>
                                controller.password = newValue!,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: ColorsStyle.primaryColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Consumer<AuthController>(
                          builder: (context, controller, child) =>
                              controller.isLoading
                                  ? const LoadingWidget()
                                  : PrimaryButton(
                                      onClick: () => controller.submit(context),
                                      text: "Sign in",
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
