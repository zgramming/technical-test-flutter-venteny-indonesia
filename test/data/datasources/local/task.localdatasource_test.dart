import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:technical_test_venteny_indonesia/src/config/constant.dart';
import 'package:technical_test_venteny_indonesia/src/config/enum.dart';
import 'package:technical_test_venteny_indonesia/src/data/datasources/local/task.localdatasource.dart';
import 'package:technical_test_venteny_indonesia/src/data/models/dto/task_create_or_update.dto.dart';
import 'package:technical_test_venteny_indonesia/src/data/models/task.model.dart';

import '../../../helper/test_helper.mocks.dart';

final testNow = DateTime(2021, 10, 10);
final testDateMilisecond = testNow.millisecondsSinceEpoch;

final testTask = TaskModel(
  id: 1,
  title: "Test Title",
  description: "Test Description",
  dueDate: testNow,
  status: TaskStatus.pending.toString().split('.').last,
);

final testDto = TaskCreateOrUpdateDto(
  title: "Test Title",
  description: "Test Description",
  dueDate: testNow,
  status: TaskStatus.pending.toString().split('.').last,
);

final testTaskMap = {
  'id': 1,
  'title': 'Test Title',
  'description': 'Test Description',
  'dueDate': testDateMilisecond,
  'status': 'pending',
};

void main() {
  late TaskLocalDataSourceImpl taskLocalDataSourceImpl;
  late MockDatabase mockDatabase;
  late MockDatabaseSQLiteHelper mockDatabaseSQLiteHelper;

  setUp(() {
    mockDatabase = MockDatabase();
    mockDatabaseSQLiteHelper = MockDatabaseSQLiteHelper();
    taskLocalDataSourceImpl = TaskLocalDataSourceImpl(
      databaseSQLiteHelper: mockDatabaseSQLiteHelper,
    );

    when(mockDatabaseSQLiteHelper.database)
        .thenAnswer((_) async => mockDatabase);
  });

  group("Task Local Data Source", () {
    // Get Task
    test("Get Task", () async {
      when(mockDatabase.query(kTableTask)).thenAnswer((_) async => [
            testTaskMap,
          ]);

      final result = await taskLocalDataSourceImpl.get();

      expect(result.length, 1);
      expect(result.first.id, testTask.id);
      expect(result.first.title, testTask.title);
    });

    // Get Task By ID

    test("Get Task By ID", () async {
      when(mockDatabase.query(
        kTableTask,
        where: 'id = ?',
        whereArgs: [testTask.id],
      )).thenAnswer((_) async => [
            testTaskMap,
          ]);

      final result = await taskLocalDataSourceImpl.getById(testTask.id);

      expect(result.id, testTask.id);
      expect(result.title, testTask.title);
    });

    // Add Task
    test('should insert a new task and return a TaskOperationResponseModel',
        () async {
      // Stub the `insert` method of `Database`
      when(mockDatabase.insert(
        kTableTask,
        testDto.toMap(),
        // nullColumnHack: null,
        // conflictAlgorithm: null,
      )).thenAnswer((_) async => 1);

      // Stub the `query` method to return a mock TaskModel
      when(mockDatabase.query(
        kTableTask,
        where: 'id = ?',
        whereArgs: [1],
      )).thenAnswer((_) async => [testTask.toMap()]);

      // Act
      final result = await taskLocalDataSourceImpl.add(testDto);

      // Assert
      expect(result.success, true);
      expect(result.message, 'Task created successfully');
      expect(result.data, testTask);

      // Verify that `insert` was called
      verify(mockDatabase.insert(
        kTableTask,
        testDto.toMap(),
        nullColumnHack: null,
        conflictAlgorithm: null,
      )).called(1);

      // Verify that `query` was called
      verify(mockDatabase.query(
        kTableTask,
        where: 'id = ?',
        whereArgs: [1],
      )).called(1);
    });

    // Update Task
    test('should update a task and return a TaskOperationResponseModel',
        () async {
      // Stub the `update` method of `Database`
      when(mockDatabase.update(
        kTableTask,
        testDto.toMap(),
        where: 'id = ?',
        whereArgs: [testTask.id],
        // conflictAlgorithm: null,
      )).thenAnswer((_) async => 1);

      // Stub the `query` method to return a mock TaskModel
      when(mockDatabase.query(
        kTableTask,
        where: 'id = ?',
        whereArgs: [testTask.id],
      )).thenAnswer((_) async => [testTask.toMap()]);

      // Act
      final result = await taskLocalDataSourceImpl.update(testTask.id, testDto);

      // Assert
      expect(result.success, true);
      expect(result.message, 'Task updated successfully');
      expect(result.data, testTask);

      // Verify that `update` was called
      verify(mockDatabase.update(
        kTableTask,
        testDto.toMap(),
        where: 'id = ?',
        whereArgs: [testTask.id],
        conflictAlgorithm: null,
      )).called(1);

      // Verify that `query` was called
      verify(mockDatabase.query(
        kTableTask,
        where: 'id = ?',
        whereArgs: [testTask.id],
      )).called(1);
    });

    // Delete Task
    test('should delete a task and return a TaskOperationResponseModel',
        () async {
      // Stub the `delete` method of `Database`
      when(mockDatabase.delete(
        kTableTask,
        where: 'id = ?',
        whereArgs: [testTask.id],
      )).thenAnswer((_) async => 1);

      // Stub the `query` method to return a mock TaskModel
      when(mockDatabase.query(
        kTableTask,
        where: 'id = ?',
        whereArgs: [testTask.id],
      )).thenAnswer((_) async => [testTask.toMap()]);

      // Act
      final result = await taskLocalDataSourceImpl.delete(testTask.id);

      // Assert
      expect(result.success, true);
      expect(result.message, 'Task deleted successfully');
      expect(result.data, testTask);

      // Verify that `delete` was called
      verify(mockDatabase.delete(
        kTableTask,
        where: 'id = ?',
        whereArgs: [testTask.id],
      )).called(1);
    });
  });
}
