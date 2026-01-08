import 'package:annotations_app/src/data/database/database_helper.dart';
import 'package:annotations_app/src/data/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UsersDao {
  const UsersDao();

  Future<Database> get _db async => LocalDatabase.instance;

  Future<User?> findById(int id) async {
    final db = await _db;
    final rows = await db.query(
      'users',
      where: 'id = ? AND deleted_at IS NULL',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return User.fromMap(rows.first);
  }

  Future<User?> findByEmail(String email) async {
    final db = await _db;
    final rows = await db.query(
      'users',
      where: 'email = ? AND deleted_at IS NULL',
      whereArgs: [email.trim().toLowerCase()],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return User.fromMap(rows.first);
  }

  Future<int> insert(User user) async {
    final db = await _db;
    final map = user.toMap()..remove('id');
    return db.insert('users', map);
  }

  Future<int> softDelete(int id) async {
    final db = await _db;
    return db.update(
      'users',
      {
        'deleted_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
