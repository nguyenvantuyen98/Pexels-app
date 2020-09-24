import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class AppDatabase {
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'media_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE media_data(id TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertMediaData(String id) async {
    final Database db = await getDatabase();

    await db.insert(
      'media_data',
      {'id': id},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<String>> mediaData() async {
    final Database db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('media_data');

    return List.generate(maps.length, (i) {
      return maps[i]['id'];
    });
  }

  Future<void> deleteMediaData(String id) async {
    final db = await getDatabase();

    await db.delete(
      'media_data',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<bool> isContain(String id) async {
    final db = await getDatabase();
    var count = firstIntValue(await db.query('media_data',
        columns: ['COUNT(*)'], where: 'id = ?', whereArgs: [id]));
    return count > 0;
  }
}

final AppDatabase appDatabase = AppDatabase();
