import 'package:sqflite/sqflite.dart';

import 'package:test_project/data/local/entities/user_entity.dart';

class LocalUserService {
  final Database db;

  LocalUserService({required this.db});

  Future<UserEntity?> findUserByLogin(String userLogin) async {
    final maps = await db.query(UserEntity.tableName, where: '${UserEntity.columnLogin} = ?', whereArgs: [userLogin]);
    if (maps.isEmpty) return null;
    return UserEntity.fromMap(maps[0]);
  }

  Future<bool> checkPassword(String userLogin, String hashPassword) async {
    final maps = await db.query(UserEntity.tableName,
        where: '${UserEntity.columnLogin} = ? AND ${UserEntity.columnPassword} = ?',
        whereArgs: [userLogin, hashPassword]);
    if (maps.isEmpty) return false;
    return true;
  }

  Future<void> saveUser(String userLogin, String hashPassword) async {
    await db.insert(UserEntity.tableName, UserEntity(login: userLogin, hashPassword: hashPassword).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
