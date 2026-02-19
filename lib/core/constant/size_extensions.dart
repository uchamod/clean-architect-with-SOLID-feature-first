import 'package:flutter/material.dart';

extension ContextSizeExtension on BuildContext {
  // Now you can get height and width instantly from any context
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}
