import 'package:annotations_app/src/data/database/database_helper.dart';
import 'package:annotations_app/src/data/models/annotation.dart';
import 'package:sqflite/sqflite.dart';

class AnnotationsDao {
  const AnnotationsDao();

  Future<Database> get _db async => LocalDatabase.instance;
  static const String _tableName = 'annotations';

  Future<Annotation?> findById(int id) async {
    final db = await _db;
    final rows = await db.query(
      _tableName,
      where: 'id = ? AND deleted_at IS NULL',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) return null;
    return Annotation.fromMap(rows.first);
  }

  Future<List<Annotation>> findByUserId(int userId) async {
    final db = await _db;
    final rows = await db.query(
      _tableName,
      where: 'user_id = ? AND deleted_at IS NULL',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );

    return rows.map(Annotation.fromMap).toList();
  }

  Future<List<Annotation>> findDeletedByUserId(int userId) async {
    final db = await _db;
    final rows = await db.query(
      _tableName,
      where: 'user_id = ? AND deleted_at IS NOT NULL',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );

    return rows.map(Annotation.fromMap).toList();
  }

  Future<int> insert(Annotation newAnnotation) async {
    final db = await _db;
    final map = newAnnotation.toMap()..remove('id');
    return db.insert(_tableName, map);
  }

  Future<int> update(Annotation annotation) async {
    final db = await _db;
    return db.update(
      _tableName,
      annotation.toMap(),
      where: 'id = ?',
      whereArgs: [annotation.id],
    );
  }

  Future<int> softDelete(int id) async {
    final db = await _db;
    return db.update(
      _tableName,
      {
        'deleted_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
