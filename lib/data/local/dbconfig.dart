import 'package:sqflite/sqflite.dart';

import 'entities/user_entity.dart';

class LocalDatabase {
  static const databaseName = 'bored.db';
  static Database? _database;

  Future<Database> getInstance() async {
    _database ??= await openDatabase(
      databaseName,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(UserEntity.create());
      },
    );
    return _database!;
  }

  Future<Database> get database async {
    if (_database == null) {
      return await getInstance();
    } else {
      return _database!;
    }
  }

  close() async {
    await _database?.close();
  }
}
