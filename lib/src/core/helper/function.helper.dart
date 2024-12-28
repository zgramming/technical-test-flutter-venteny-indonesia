import 'package:flutter/material.dart';
import '../../config/font.dart';

class FunctionHelper {
  static InputDecoration inputFilledDecoration({
    final String? hintText,
    final Widget? suffixIcon,
  }) {
    return InputDecoration(
      fillColor: Colors.grey[200],
      filled: true,
      hintText: hintText,
      hintStyle: bodyFont.copyWith(
        fontSize: 12,
        color: Colors.grey,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(8),
      suffixIcon: suffixIcon,
    );
  }
}
