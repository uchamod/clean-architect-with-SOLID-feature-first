import 'package:clen_archetecture_bloc_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BlogTextEditor extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  const BlogTextEditor({
    super.key,
    required this.hintText,
    required this.controller,
    required this.textInputType,
    required this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: null,

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
        border: AppTheme.inputFieldDecoration,
        enabledBorder: AppTheme.inputFieldDecoration,
        focusedBorder: AppTheme.inputFieldDecoration,
      ),
    );
  }
}
