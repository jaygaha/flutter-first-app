import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List<Map<String, dynamic>> toDoList = [];
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
    final storedList = _toDoBox.get("TODOLIST");
    if (storedList != null) {
      toDoList = storedList.map<Map<String, dynamic>>((task) {
        if (task is Map) {
          return {
            "title": task["title"] ?? "",
            "isCompleted": task["isCompleted"] ?? false,
            "dueDate": task["dueDate"] != null
                ? DateTime.parse(task["dueDate"])
                : null,
          };
        } else if (task is List && task.length >= 2) {
          // migrate old format
          return {
            "title": task[0].toString(),
            "isCompleted": task[1] ?? false,
            "dueDate": null,
          };
        } else {
          return {"title": "", "isCompleted": false, "dueDate": null};
        }
      }).toList();
    } else {
      createInitData();
    }
  }

  // update database
  void updateData() {
    // store dueDate as ISO string
    final listToStore = toDoList.map((task) {
      return {
        "title": task["title"],
        "isCompleted": task["isCompleted"],
        "dueDate": task["dueDate"]?.toIso8601String(),
      };
    }).toList();

    _toDoBox.put("TODOLIST", listToStore);
  }
}
