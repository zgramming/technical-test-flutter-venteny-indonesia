import 'package:flutter/material.dart';
import '../../config/font.dart';

class FunctionHelper {
  static void showSnackBar({
    required final BuildContext context,
    required final String message,
    final Color color = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: bodyFont.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }

  static InputDecoration inputFilledDecoration({
    final String? hintText,
    final Widget? suffixIcon,
    final Widget? prefixIcon,
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
      prefixIcon: prefixIcon,
    );
  }
}
