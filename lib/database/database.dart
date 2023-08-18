// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:week3_sqlite_database/dao/TodoDao.dart';
import 'package:week3_sqlite_database/entity/Todo.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Todo])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
