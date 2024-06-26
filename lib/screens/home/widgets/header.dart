import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/helpers/helper.dart';
import 'package:task_manager/helpers/icon_path.dart';
import 'package:task_manager/providers/auth.dart';
import 'package:task_manager/providers/home.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/styles/theme.dart';
import 'package:task_manager/widgets/custom_cached_network.dart';
import 'package:task_manager/widgets/rounded_clipper.dart';

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, controller, child) => ClipPath(
        clipper: RoundedClipper(),
        child: Container(
          width: double.infinity,
          height: deviceHeight(context) * 0.2,
          decoration: const BoxDecoration(
            gradient: ThemesStyle.gredientColor,
          ),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 30,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: ColorsStyle.whiteColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomCachedNetworkWidget(
                    link: controller.user.image,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.user.username,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsStyle.whiteColor,
                      ),
                    ),
                    Text(
                      controller.user.email,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsStyle.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  context
                      .read<HomeController>()
                      .scaffoldKey
                      .currentState
                      ?.openEndDrawer();
                },
                child: SvgPicture.asset(
                  IconsPathHelper.drawer,
                  width: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
