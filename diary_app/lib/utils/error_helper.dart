// lib/utils/error_helper.dart
import 'package:flutter/material.dart';

class ErrorHelper {
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: "OK",
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  static void showWarning(BuildContext context, String message, {VoidCallback? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orangeAccent,
        duration: const Duration(seconds: 6),
        action: action != null
            ? SnackBarAction(
                label: "TRY AGAIN",
                textColor: Colors.white,
                onPressed: action,
              )
            : null,
      ),
    );
  }
}