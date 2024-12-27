import 'package:flutter/material.dart';

import '../../config/font.dart';

class RowTitle extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionPressed;
  const RowTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: headerFont.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (actionText != null)
          TextButton(
            onPressed: onActionPressed,
            child: Text(
              actionText!,
              style: bodyFont.copyWith(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          )
      ],
    );
  }
}
