import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class JournalDatabase {
  static final JournalDatabase instance = JournalDatabase._init();
  static Database? _database;

  JournalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('journal_entries.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE journal_entries(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT NOT NULL,
            date TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertEntry(String content) async {
    final db = await instance.database;
    await db.insert('journal_entries', {
      'content': content,
      'date': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getEntries() async {
    final db = await instance.database;
    return await db.query('journal_entries', orderBy: 'id DESC');
  }

  Future<int> deleteEntry(int id) async {
    final db = await instance.database;
    return await db.delete('journal_entries', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
