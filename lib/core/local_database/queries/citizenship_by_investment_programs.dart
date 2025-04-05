import 'package:admin/core/local_database/init.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Database get db => DatabaseHelper().db;

Future<void> insertCitizenshipByInvestmentRecord(
    String program, String country, String investment) async {
  await db.insert(
    'citizenship_by_investment_programs',
    {
      'program': program,
      'country': country,
      'investment': investment,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Map<String, dynamic>>>
    getAllCitizenshipByInvestmentRecords() async {
  return await db.query('citizenship_by_investment_programs');
}

Future<void> updateCitizenshipByInvestmentRecord(
    int id, String program, String country, String investment) async {
  await db.update(
    'citizenship_by_investment_programs',
    {'program': program, 'country': country, 'investment': investment},
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> deleteCitizenshipByInvestmentRecord(int id) async {
  await db.delete('citizenship_by_investment_programs',
      where: 'id = ?', whereArgs: [id]);
}
