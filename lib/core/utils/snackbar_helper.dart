import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnackbarHelper {
  static void showError(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: message, backgroundColor: Colors.redAccent),
      displayDuration: const Duration(seconds: 3),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: message, backgroundColor: Colors.green),
      displayDuration: const Duration(seconds: 3),
    );
  }

  static void showInfo(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(message: message, backgroundColor: Colors.blueAccent),
      displayDuration: const Duration(seconds: 3),
    );
  }
}
