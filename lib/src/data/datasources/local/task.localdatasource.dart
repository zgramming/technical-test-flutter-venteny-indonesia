import '../../../config/constant.dart';
import '../../../core/helper/database_sqlite.helper.dart';
import '../../models/dto/task_create_or_update.dto.dart';
import '../../models/task.model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> get();
  Future<TaskModel> getById(int id);
  Future<List<TaskModel>> add(TaskCreateOrUpdateDto task);
  Future<List<TaskModel>> update(int id, TaskCreateOrUpdateDto task);
  Future<List<TaskModel>> delete(int id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final DatabaseSQLiteHelper databaseSQLiteHelper;
  TaskLocalDataSourceImpl({
    required this.databaseSQLiteHelper,
  });

  @override
  Future<List<TaskModel>> get() async {
    final db = await databaseSQLiteHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(kTableTask);
    final result = List<TaskModel>.from(maps.map((x) => TaskModel.fromMap(x)));
    return result;
  }

  @override
  Future<TaskModel> getById(int id) async {
    final db = await databaseSQLiteHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      kTableTask,
      where: 'id = ?',
      whereArgs: [id],
    );

    return TaskModel.fromMap(maps.first);
  }

  @override
  Future<List<TaskModel>> add(TaskCreateOrUpdateDto task) async {
    final db = await databaseSQLiteHelper.database;
    await db.insert(kTableTask, task.toMap());
    return get();
  }

  @override
  Future<List<TaskModel>> update(int id, TaskCreateOrUpdateDto task) async {
    final db = await databaseSQLiteHelper.database;
    await db.update(
      kTableTask,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );

    return get();
  }

  @override
  Future<List<TaskModel>> delete(int id) async {
    final db = await databaseSQLiteHelper.database;
    await db.delete(
      kTableTask,
      where: 'id = ?',
      whereArgs: [id],
    );

    return get();
  }
}
