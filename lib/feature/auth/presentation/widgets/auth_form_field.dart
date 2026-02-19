import 'package:clen_archetecture_bloc_app/core/theme/app_colors.dart';
import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool isVisible;
  const AuthFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    required this.textInputAction,
    this.isVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: 1,
      obscureText: isVisible,
      obscuringCharacter: "*",
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTheme.lableTextTheme,
        contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColorPallete.gradient1,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColorPallete.gradient1,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColorPallete.gradient1,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }

  static _textborder() => {
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: AppColorPallete.greyColor,
        width: 1,
        style: BorderStyle.none,
      ),
    ),
  };
}
