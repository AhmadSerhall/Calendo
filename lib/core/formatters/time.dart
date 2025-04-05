import 'package:intl/intl.dart';

/// Formats a Shopify `created_at` timestamp into a readable string.
///
/// Example Input: "2025-01-15T10:00:00-05:00"
/// Example Output: "January 15, 2025, 10:00 AM"
String formatShopifyTime(String createdAt) {
  try {
    final DateTime dateTime = DateTime.parse(createdAt);
    final DateFormat formatter = DateFormat('MMMM dd, yyyy, hh:mm a');
    return formatter.format(dateTime);
  } catch (e) {
    return 'Invalid Date';
  }
}

/// Formats a date string to "dd-MM-yyyy HH:mm".
String formatDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '';
  final dateTime = DateTime.tryParse(dateStr);
  if (dateTime == null) return dateStr;
  return DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
}

String formatDateOnly(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '';
  final dateTime = DateTime.tryParse(dateStr);
  if (dateTime == null) return dateStr;
  return DateFormat('dd-MM-yyyy').format(dateTime);
}
