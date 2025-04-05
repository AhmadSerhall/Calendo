import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showSuccessToast(BuildContext context, String message) {
  showToast(
      context, 'Success', message, ToastificationType.success, Colors.green);
}

void showInfoToast(BuildContext context, String message) {
  showToast(context, 'Info', message, ToastificationType.info, Colors.blue);
}

void showWarningToast(BuildContext context, String message) {
  showToast(
      context, 'Warning', message, ToastificationType.warning, Colors.orange);
}

void showErrorToast(BuildContext context, String message) {
  showToast(context, 'Error', message, ToastificationType.error, Colors.red);
}

void showToast(BuildContext context, String title, String description,
    ToastificationType type, Color backgroundColor) {
  toastification.show(
    context: context,
    type: type,
    //title: Text(title),
    description: Text(description),
    primaryColor: Colors.white,
    autoCloseDuration: const Duration(seconds: 2),
    closeButtonShowType: CloseButtonShowType.none,
    /* progressBarTheme: ProgressIndicatorThemeData(
      color: Colors.white,
    ), */
    showProgressBar: false,
    backgroundColor: backgroundColor,
    foregroundColor: Colors.white,
    borderSide: const BorderSide(width: 0),
  );
}
