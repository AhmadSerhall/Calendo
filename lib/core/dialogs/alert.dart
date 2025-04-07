import 'package:admin/core/constants/text_styles.dart';
import 'package:flutter/material.dart';

Future<void> showCustomMacOSAlert({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    barrierDismissible:
        false, // Prevents dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      // Calculate max width as 33% of the screen width.
      final maxWidth = MediaQuery.of(context).size.width * 0.33;
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 8,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            // The dialog will take only the needed width and height, but never exceed maxWidth.
            maxWidth: maxWidth,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Sizes vertically to the content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(title, style: headline2),
                const SizedBox(height: 12),
                // Message
                Text(message, style: bodyText1),
                const SizedBox(height: 20),
                // Button Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Cancel Button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel', style: bodyText1),
                    ),
                    const SizedBox(width: 8),
                    // Confirm Button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      child: Text('Confirm', style: bodyText1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
