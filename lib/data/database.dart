import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  // reference the hive box
  final _toDoBox = Hive.box('todoBox');

  // run this method if this class is called for the first time ever
  void createInitData() {
    // default data seeder
    // [["task 1", true], ["task 2", false]]
    toDoList = [];
  }

  // load the data from the db
  void loadData() {
    toDoList = _toDoBox.get("TODOLIST");
  }

  // update database
  void updateData() {
    _toDoBox.put("TODOLIST", toDoList);
  }
}
