import '../../../config/constant.dart';
import '../../../core/helper/database_sqlite.helper.dart';
import '../../models/dto/task_create_or_update.dto.dart';
import '../../models/response/task_operation_response.model.dart';
import '../../models/task.model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> get();
  Future<TaskModel> getById(int id);
  Future<TaskOperationResponseModel> add(TaskCreateOrUpdateDto task);
  Future<TaskOperationResponseModel> update(int id, TaskCreateOrUpdateDto task);
  Future<TaskOperationResponseModel> delete(int id);
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
  Future<TaskOperationResponseModel> add(TaskCreateOrUpdateDto task) async {
    final db = await databaseSQLiteHelper.database;
    final id = await db.insert(
      kTableTask,
      task.toMap(),
    );
    final newTask = await getById(id);

    return TaskOperationResponseModel(
      success: true,
      message: 'Task created successfully',
      data: newTask,
    );
  }

  @override
  Future<TaskOperationResponseModel> update(
    int id,
    TaskCreateOrUpdateDto task,
  ) async {
    final db = await databaseSQLiteHelper.database;
    await db.update(
      kTableTask,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );

    final newestTask = await getById(id);

    return TaskOperationResponseModel(
      success: true,
      message: 'Task updated successfully',
      data: newestTask,
    );
  }

  @override
  Future<TaskOperationResponseModel> delete(int id) async {
    final db = await databaseSQLiteHelper.database;

    final task = await getById(id);

    await db.delete(
      kTableTask,
      where: 'id = ?',
      whereArgs: [id],
    );

    return TaskOperationResponseModel(
      success: true,
      message: 'Task deleted successfully',
      data: task,
    );
  }
}
