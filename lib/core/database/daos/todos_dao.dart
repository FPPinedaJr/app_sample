import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/todos_table.dart';

part 'todos_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  TodosDao(super.db);

  // READ: Watch all todos as a Stream. The UI will automatically rebuild when this changes.
  Stream<List<Todo>> watchAllTodos() => select(todos).watch();

  // CREATE: Insert a new todo
  Future<int> insertTodo(TodosCompanion todo) => into(todos).insert(todo);

  // UPDATE: Toggle the completion status
  Future<bool> updateTodo(Todo todo) => update(todos).replace(todo);

  // DELETE: Remove a todo
  Future<int> deleteTodo(Todo todo) => delete(todos).delete(todo);
}
