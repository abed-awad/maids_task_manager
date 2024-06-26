import 'package:flutter/material.dart';
import 'package:task_manager/styles/color.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;
  final Color? color;

  const CustomSafeArea({
    super.key,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? ColorsStyle.whiteColor,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
