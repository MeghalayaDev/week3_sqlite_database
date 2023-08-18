import 'package:flutter/material.dart';
import 'package:week3_sqlite_database/database/database.dart';
import 'package:week3_sqlite_database/entity/Todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(SQLiteDBExample(database));
}

class SQLiteDBExample extends StatefulWidget {
  AppDatabase database;
  SQLiteDBExample(this.database, {super.key});

  @override
  State<SQLiteDBExample> createState() => _SQLiteDBExampleState();
}

class _SQLiteDBExampleState extends State<SQLiteDBExample> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController = TextEditingController();

  var todoDao;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    todoDao = widget.database.todoDao;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SQLite Database Example!!"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                children: [
                  TextFormField(
                    controller: titleEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Please give some title',
                      labelText: 'Title *',
                    ),
                  ),
                  TextFormField(
                    controller: descriptionEditingController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Please give some description',
                      labelText: 'Description *',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print(titleEditingController.text);
                      print(descriptionEditingController.text);

                      saveToDB(Todo(titleEditingController.text, descriptionEditingController.text));
                      titleEditingController.text = "";
                      descriptionEditingController.text = "";

                      setState(() {});
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 300,
                child: FutureBuilder(
                  future: getTodos(),
                  builder: (BuildContext context, AsyncSnapshot<List<Todo>?> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].title),
                            subtitle: Text(snapshot.data![index].description),
                            trailing: InkWell(
                              onTap: () {
                                delete(snapshot.data![index]);
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveToDB(Todo todo) async {
    await todoDao.insertTodo(todo);
  }

  Future<List<Todo>> getTodos() async {
    return todoDao.findAll();
  }

  Future<void> delete(Todo todo) async {
    return todoDao.deleteTodo(todo);
  }
}
