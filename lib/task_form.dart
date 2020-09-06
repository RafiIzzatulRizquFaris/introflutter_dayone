import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introflutter_dayone/operation.dart';
import 'package:introflutter_dayone/task.dart';

class TaskFormScreen extends StatefulWidget {
  final String state;
  final Task task;

  TaskFormScreen({Key key, this.state, this.task}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TaskFormState(this.state, this.task);
  }
}

class TaskFormState extends State<TaskFormScreen> {
  String state;
  Operation _operation = Operation();
  Task task;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  TaskFormState(String state, Task task);

  @override
  void initState() {
    super.initState();
    if (widget.state != "insert") {
      titleController.text = widget.task.title;
      descController.text = widget.task.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Stack(
        children: [
          circleDecoration(),
          mainScreen(),
        ],
      ),
    );
  }

  mainScreen() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.state == "insert"
                  ? "Insert \nSome New Task"
                  : "Update Task",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: 30,
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: descController,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FlatButton(
                      splashColor: Colors.greenAccent,
                      color: Colors.green,
                      textColor: Colors.white70,
                      padding: EdgeInsets.all(10),
                      onPressed: () async {
                        if (widget.state == "insert") {
                          task = Task(
                            title: titleController.text,
                            description: descController.text,
                          );
                          _operation.insertData(task);
                          Navigator.pop(context, "data updated");
                        } else {
                          task = Task(
                            title: titleController.text,
                            description: descController.text,
                            id: widget.task.id,
                          );
                          _operation.updateData(task);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  circleDecoration() {
    return Stack(
      children: [
        Positioned(
          top: -64,
          right: -128,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9000),
              color: Colors.blue,
            ),
          ),
        ),
        Positioned(
          top: -164,
          right: -8.0,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9000),
                color: Colors.red.withOpacity(0.8),
                backgroundBlendMode: BlendMode.hardLight),
          ),
        ),
      ],
    );
  }
}
