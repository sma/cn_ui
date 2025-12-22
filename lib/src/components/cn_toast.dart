import 'package:flutter/material.dart';

/// A utility class for displaying simple toast notifications.
///
/// Provides a static method to show temporary messages using Flutter's SnackBar.
///
/// See also:
///
///  * [CnSonner], for more feature-rich toast notifications.
///  * [CnAlert], for persistent alert messages.
class CnToast {
  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: actionLabel == null
            ? null
            : SnackBarAction(label: actionLabel, onPressed: onAction ?? () {}),
      ),
    );
  }
}
