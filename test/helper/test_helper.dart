import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:technical_test_venteny_indonesia/src/core/helper/database_sqlite.helper.dart';
import 'package:technical_test_venteny_indonesia/src/data/datasources/local/task.localdatasource.dart';

@GenerateMocks([TaskLocalDataSource, DatabaseSQLiteHelper, Database],
    customMocks: [])
void main() {}
