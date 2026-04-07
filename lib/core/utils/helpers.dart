import 'package:flutter/material.dart';

class Helpers {
  static void showSnackBar(
      BuildContext context,
      String message, {
        SnackType type = SnackType.success,
      }) {
    final Color bgColor = _getBackgroundColor(type);
    final IconData icon = _getIcon(type);

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: 16,
      ),
      content: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.038,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Color _getBackgroundColor(SnackType type) {
    switch (type) {
      case SnackType.success:
        return Colors.green.shade600;
      case SnackType.error:
        return Colors.red.shade600;
      case SnackType.warning:
        return Colors.orange.shade600;
      case SnackType.info:
        return Colors.blue.shade600;
    }
  }

  static IconData _getIcon(SnackType type) {
    switch (type) {
      case SnackType.success:
        return Icons.check_circle;
      case SnackType.error:
        return Icons.error;
      case SnackType.warning:
        return Icons.warning;
      case SnackType.info:
        return Icons.info;
    }
  }
}

enum SnackType { success, error, warning, info }