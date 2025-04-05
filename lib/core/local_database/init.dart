import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  Database get db {
    if (_db == null) {
      throw Exception('Database not initialized. Call await init() first.');
    }
    return _db!;
  }

  Future<void> init() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    _db = await openDatabase(
      'maindb.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE citizenship_by_investment_programs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            program TEXT,
            country TEXT,
            investment TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE residency_by_investment_programs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category TEXT,
            country TEXT,
            program TEXT,
            value TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE embassy_guide (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country TEXT,
            embassy TEXT,
            ivs TEXT,
            agency TEXT,
            process TEXT,
            address TEXT,
            phones TEXT,
            mobile TEXT,
            contact TEXT,
            services TEXT,
            email TEXT,
            website TEXT,
            office_hours TEXT,
            suppliers TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE residency_agents (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country TEXT,
            agent_name TEXT,
            agent_code TEXT,
            price REAL,
            basic_info TEXT,
            additional_info TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE citizenship_agents (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country TEXT,
            program TEXT,
            agent_name TEXT,
            agent_code TEXT,
            price REAL,
            benefits TEXT,
            additional_info TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE clients (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT,
            email TEXT,
            address TEXT,
            year INTEGER
          )
        ''');

        await db.execute('''
        CREATE TABLE contacts_book (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          company_name TEXT,
          phone1 TEXT,
          phone2 TEXT,
          extension TEXT,
          mobile TEXT,
          services TEXT,
          contact_name TEXT,
          position TEXT,
          address TEXT,
          email TEXT,
          website TEXT
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {}
      },
    );
  }

  Future<void> close() async {
    await db.close();
  }

  Future<void> reinitializeDatabase() async {
    await db.close();
    await deleteDatabase('maindb.db');
    await init();
  }
}
