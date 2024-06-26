import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:task_manager/models/task.dart';

class SQFLiteDatabaseService {
  final String tableName = "todos";

  static final SQFLiteDatabaseService _instance =
      SQFLiteDatabaseService._internal();
  static Database? _database;

  SQFLiteDatabaseService._internal();

  factory SQFLiteDatabaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, todo TEXT, completed INTEGER)",
        );
      },
    );
  }

  Future<void> insertAllTodos(List<TodoModel> todos) async {
    final db = await database;
    Batch batch = db.batch();
    for (var todo in todos) {
      batch.insert(
        tableName,
        todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<void> insertTodo(TodoModel todo) async {
    final db = await database;
    await db.insert(
      tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TodoModel>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return TodoModel.fromMapLocal(maps[i]);
    });
  }

  Future<void> updateTodo(TodoModel todo) async {
    final db = await database;
    await db
        .update(tableName, todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
