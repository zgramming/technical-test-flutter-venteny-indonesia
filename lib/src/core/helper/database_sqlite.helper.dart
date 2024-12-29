import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const kDatabaseName = 'task_manager.db';

class DatabaseSQLiteHelper {
  static final DatabaseSQLiteHelper instance = DatabaseSQLiteHelper._init();

  static Database? _database;

  DatabaseSQLiteHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(kDatabaseName);
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
      onDowngrade: _downgradeDB,
      onConfigure: _configureDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        dueDate INTEGER,
        status TEXT  
      )
    ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    // Run migration according to the oldVersion and newVersion
  }

  Future<void> _downgradeDB(Database db, int oldVersion, int newVersion) async {
    // Run migration according to the oldVersion and newVersion
  }

  Future<void> _configureDB(Database db) async {
    // Enable foreign key
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
