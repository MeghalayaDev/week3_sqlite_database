import 'package:floor/floor.dart';
import 'package:week3_sqlite_database/entity/Todo.dart';

@dao
abstract class TodoDao {
  @insert
  Future<void> insertTodo(Todo todo);

  @Query('SELECT * FROM Todo')
  Future<List<Todo>> findAll();

  @delete
  Future<void> deleteTodo(Todo todo);
  @update
  Future<void> updateTodo(Todo todo);
}
