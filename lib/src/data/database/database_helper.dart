import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'migrations/v1.dart';

class LocalDatabase {
  static const String _dbName = 'annotations.db';

  // Incrimental para versão do databse
  static const int _dbVersion = 1;

  static Database? _instance;

  static Future<Database> get instance async {
    if (_instance != null) return _instance!;
    _instance = await _initDatabase();
    return _instance!;
  }

  // Inicializa o database
  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,

      // Caso algo tente abrir o DB com versão menor, reset total
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  // Executa ao criar o database no aparelho pela primeira vez
  static Future<void> _onCreate(Database db, int version) async {
    await db.transaction((txn) async {
      await _runMigrationV1(txn);
    });
  }

  // Executa alterações no database caso a versão aumente
  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    await db.transaction((txn) async {
      if (oldVersion < 1) await _runMigrationV1(txn);
    });
  }

  // MIGRATIONS - START

  // V1
  static Future<void> _runMigrationV1(DatabaseExecutor db) async {
    final statements = migrationV1.split(';');

    for (final stmt in statements) {
      final sql = stmt.trim();
      if (sql.isNotEmpty) {
        await db.execute('$sql;');
      }
    }
  }

  // MIGRATIONS - END
}
