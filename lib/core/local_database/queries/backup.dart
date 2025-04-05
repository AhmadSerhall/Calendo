import 'dart:convert';
import 'dart:io';
import 'package:admin/core/local_database/init.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Database db = DatabaseHelper().db;

/* Future<void> exportDatabaseAsText(String filePath) async {
  final buffer = StringBuffer();

  // Get list of all tables
  final tables = await db.rawQuery(
    "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
  );

  for (var table in tables) {
    final tableName = table['name'] as String;
    buffer.writeln('Table: $tableName');
    buffer.writeln('-' * 40);

    // Get all data from the table
    final rows = await db.query(tableName);

    for (var row in rows) {
      buffer.writeln(row.entries.map((e) => '${e.key}: ${e.value}').join(', '));
    }

    buffer.writeln('\n\n');
  }

  // Write to a .txt file
  final file = File(filePath);
  await file.writeAsString(buffer.toString());

  print('✅ Backup saved to: ${file.absolute.path}');
} */

Future<void> exportDatabaseAsJson(String filePath) async {
  final Map<String, dynamic> backupData = {};

  // Get list of all user tables (ignoring internal SQLite tables)
  final tables = await db.rawQuery(
    "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';",
  );

  for (var table in tables) {
    final tableName = table['name'] as String;
    // Get all data from the current table
    final rows = await db.query(tableName);
    backupData[tableName] = rows;
  }

  // Convert backup data to a nicely formatted JSON string
  final jsonString = const JsonEncoder.withIndent('  ').convert(backupData);

  // Write to a .json file
  final file = File(filePath);
  await file.writeAsString(jsonString);

  print('✅ Backup saved to: ${file.absolute.path}');
}
