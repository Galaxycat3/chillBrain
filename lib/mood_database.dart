import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoodDatabase {
  static final MoodDatabase instance = MoodDatabase._init();
  static Database? _database;

  MoodDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mood.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE moods(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        level INTEGER NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertMood(int level) async {
    final db = await instance.database;
    return await db.insert('moods', {
      'level': level,
      'date': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getMoods() async {
    final db = await instance.database;
    return await db.query('moods', orderBy: 'date DESC');
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
