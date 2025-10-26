import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;

import 'package:mindfulnessstressreduction/journal_database.dart';
import 'package:mindfulnessstressreduction/mood_database.dart';

void main() {
  setUp(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final dbPath = await getDatabasesPath();
    await deleteDatabase(p.join(dbPath, 'journal_entries.db'));
    await deleteDatabase(p.join(dbPath, 'mood.db'));
  });

  test('Journal entries persist and read back in DESC order', () async {
    await JournalDatabase.instance.insertEntry('first');
    await JournalDatabase.instance.insertEntry('second');

    final list = await JournalDatabase.instance.getEntries();
    expect(list.length, 2);
    expect(list.first['content'], 'second');
    expect(list.last['content'], 'first');
  });

  test('Mood logs persist and return recent first', () async {
    await MoodDatabase.instance.insertMood(2);
    await Future.delayed(const Duration(milliseconds: 10));
    await MoodDatabase.instance.insertMood(5);

    final moods = await MoodDatabase.instance.getMoods();
    expect(moods.length, 2);
    expect(moods.first['level'], 5);
    expect(moods.last['level'], 2);
  });
}
