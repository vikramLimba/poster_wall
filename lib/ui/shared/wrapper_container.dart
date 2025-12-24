import 'package:flutter/material.dart';
import 'package:poster_wall/utilities/style/app_colors.dart';

Widget wrapperContainer({
  double? height,
  double? width,
  Widget? child,
  Color? color,
  EdgeInsets? padding,
  double? borderRadius,
}) {
  return Container(
    height: height,
    width: width,
    padding: padding,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(
        color: AppColors.white,
        width: 0.8,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: BorderRadius.circular(borderRadius ?? 28),
    ),
    child: child,
  );
}
