import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

// Import your new modular files
import 'tables/users_table.dart';
import 'daos/users_dao.dart';
import 'tables/todos_table.dart'; // Add this
import 'daos/todos_dao.dart';



part 'app_database.g.dart';
@DriftDatabase(
  // Register the tables and DAOs here
  tables: [Users, Todos],
  daos: [UsersDao, TodosDao], 
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'app_db'));

  @override
  int get schemaVersion => 2;
}

final appDb = AppDatabase();