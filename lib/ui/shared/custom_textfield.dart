import 'package:flutter/material.dart';
import 'package:poster_wall/utilities/style/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String? value)? validator;
  final int? maxLines;
  final bool? enable;
  final Color? borderColor;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;

  final Function(String)? onChanged;
  const CustomTextfield({
    super.key,
    this.validator,
    this.hintText,
    this.controller,
    this.maxLines,
    this.enable,
    this.borderColor,
    this.textStyle,
    this.onChanged,
    this.hintTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor ?? AppColors.white, width: 0.5),
      borderRadius: BorderRadius.circular(16),
    );

    final decoration = InputDecoration(
      hintText: hintText,
      hintStyle:
          hintTextStyle ?? TextStyle(fontSize: 14, color: AppColors.white),
      border: border,
      focusedBorder: border,
      enabledBorder: border,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );

    return TextFormField(
      style:
          textStyle ??
          TextStyle(
            fontSize: 14,
            color: AppColors.white,
            fontWeight: FontWeight.w400,
          ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: enable ?? true,
      maxLines: maxLines ?? 1,
      controller: controller,
      decoration: decoration,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
