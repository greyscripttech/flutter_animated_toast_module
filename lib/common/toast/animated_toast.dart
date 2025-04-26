
import 'package:flutter/material.dart';

enum ToastType { success, error, warning, info }

void showAnimatedToast({
  required BuildContext context,
  required String message,
  required ToastType type,
  Duration duration = const Duration(seconds: 3),
}) {
  final color = {
    ToastType.success: Colors.green,
    ToastType.error: Colors.red,
    ToastType.warning: Colors.orange,
    ToastType.info: Colors.blue,
  }[type]!;

  final icon = {
    ToastType.success: Icons.check_circle,
    ToastType.error: Icons.error,
    ToastType.warning: Icons.warning,
    ToastType.info: Icons.info,
  }[type]!;

  final toast = SnackBar(
    content: Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(child: Text(message)),
      ],
    ),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    duration: duration,
  );

  ScaffoldMessenger.of(context).showSnackBar(toast);
}
