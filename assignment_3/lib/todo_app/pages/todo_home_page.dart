import 'package:flutter/material.dart';
import 'package:state_managment/todo_app/data/tasks_data.dart';
import 'package:state_managment/todo_app/models/task_model.dart';
import 'package:state_managment/todo_app/pages/all_tasks.dart';
import 'package:state_managment/todo_app/pages/complete_tasks.dart';
import 'package:state_managment/todo_app/pages/incomplete_tasks.dart';

class TodoHomePage extends StatefulWidget {
  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  changeTaskCompleteness(Task task) {
    int index = tasksList.indexOf(task);
    tasksList[index].isCompleted = !tasksList[index].isCompleted;
    setState(() {});
  }

  void deleteTask() {
    for (var item in tasksList) {
      if (item.isCompleted) {
        setState(() {
          tasksList.remove(item);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TODO APP'),
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.list),
                text: 'All Tasks',
              ),
              Tab(
                icon: Icon(Icons.done),
                text: 'Complete Tasks',
              ),
              Tab(
                icon: Icon(Icons.cancel),
                text: 'InComplete Tasks',
              )
            ]),
          ),
          body: TabBarView(
            children: [
              Stack(
                children: [
                  AllTasksScreen(changeTaskCompleteness),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        deleteTask();
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red.shade400),
                          fixedSize:
                              MaterialStateProperty.all<Size>(Size(100, 50))),
                    ),
                    margin: const EdgeInsets.only(bottom: 50, right: 30),
                    alignment: Alignment.bottomRight,
                  )
                ],
              ),
              CompleteTasksScreen(changeTaskCompleteness),
              InCompleteTasksScreen(changeTaskCompleteness),
            ],
          ),
        ));
  }
}
