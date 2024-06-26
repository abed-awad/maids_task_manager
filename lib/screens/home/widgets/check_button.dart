import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/styles/color.dart';
import 'package:task_manager/styles/theme.dart';

class CheckButton extends StatefulWidget {
  final bool isCheck;
  final double size;
  final Function() onChange;

  const CheckButton({
    super.key,
    required this.isCheck,
    required this.onChange,
    this.size = 22,
  });

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
    value: 1.0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChange();
        _controller.reverse().then((value) => _controller.forward());
      },
      child: Container(
        width: 30.w,
        height: 30.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: widget.isCheck ? null : ColorsStyle.whiteColor,
          gradient: widget.isCheck ? ThemesStyle.gredientColor : null,
          border: widget.isCheck
              ? null
              : Border.all(color: ColorsStyle.primaryColor, width: 1),
        ),
        child: ScaleTransition(
          scale: Tween(begin: 0.7, end: 1.0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut,
            ),
          ),
          child: widget.isCheck
              ? Icon(
                  Icons.done_outline_rounded,
                  color: ColorsStyle.whiteColor,
                  size: widget.size,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
