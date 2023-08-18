import 'package:floor/floor.dart';

@entity
class Todo {
  @primaryKey
  String title;
  String description;
  Todo(
    this.title,
    this.description,
  );
}
