import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/pages/no_datapage.dart';
import 'package:to_do_app/utils/dialog_box.dart';
import 'package:to_do_app/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _todoBox = Hive.box('todoBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever opening the app, create the new db
    if (_todoBox.get("TODOLIST") == null) {
      db.createInitData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final TextEditingController textController = TextEditingController();

  // list of todo tasks

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index]["isCompleted"] = value ?? false;
    });
    db.updateData();
  }


  // save new task
  void saveNewTask(DateTime? dueDate) {
    setState(() {
      db.toDoList.add({
        "title": textController.text,
        "isCompleted": false,
        "dueDate": dueDate,
      });
      textController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  // Create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          textController: textController,
          onSave: (DateTime? selectedDate) => saveNewTask(selectedDate),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }


  // Delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(149, 215, 174, 1),
        backgroundColor: const Color.fromRGBO(250, 249, 249, 1),
        appBar: AppBar(
          title: const Text('TODO APP'),
          elevation: 0,
          // backgroundColor: const Color.fromRGBO(101, 145, 87, .5),
          backgroundColor: const Color.fromRGBO(44, 166, 164, 1),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: const Color.fromRGBO(44, 166, 164, 1),
          child: const Icon(Icons.add_sharp),
        ),
        body: db.toDoList.isEmpty
            ? const NoDataPage()
            : ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              final task = db.toDoList[index]; //shortcut to get the info from the base
              return ToDoTile(
                taskTitle: task["title"],
                isTaskCompleted: task["isCompleted"] ?? false,
                dueDate: task["dueDate"], // Added the due time
                onChanged: (value) => checkBoxChanged(value, index),
                deleteTask: (context) => deleteTask(index),
              );

            }));
  }
}
