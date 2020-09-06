import 'package:flutter/material.dart';
import 'package:introflutter_dayone/operation.dart';
import 'package:introflutter_dayone/task.dart';
import 'package:introflutter_dayone/task_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Task Planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Operation _operation = Operation();
  Future<List<Task>> future;

  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  void reassemble() {
    super.reassemble();
    updateData();
  }

  updateData() {
    setState(() {
      future = _operation.getAllSelect();
    });
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return TaskFormScreen(
              state: "insert",
            );
          })).then((value) => updateData());
        },
        tooltip: 'Add new task',
        child: Icon(Icons.add),
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
              widget.title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Task>>(
              builder: (context, snapshot) {
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return noTaskWidget();
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      Task task = snapshot.data[index];
                      return taskCard(task);
                    },
                    itemCount: snapshot.data.length,
                  );
                }
              },
              future: future,
            ),
          ),
        ],
      ),
    );
  }

  noTaskWidget() {
    return Center(
      child: Text(
        'No Task Yet',
        style: Theme.of(context).textTheme.headline6,
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
            width: 220.0,
            height: 220.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9000), color: Colors.blue),
          ),
        ),
        Positioned(
          top: -164,
          right: -8.0,
          child: Container(
            width: 220.0,
            height: 220.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9000),
                backgroundBlendMode: BlendMode.hardLight,
                color: Colors.redAccent.withOpacity(0.8)),
          ),
        ),
      ],
    );
  }

  Widget taskCard(Task task) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.people),
        ),
        title: Text(
          task.title,
        ),
        subtitle: Text(task.description),
        trailing: GestureDetector(
          child: Icon(Icons.delete),
          onTap: () async {
            await _operation.deleteData(task);
            updateData();
          },
        ),
        onTap: () async {
          print(task.title);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TaskFormScreen(
              state: "update",
              task: task,
            );
          })).then((value) => updateData());
        },
      ),
    );
  }
}
