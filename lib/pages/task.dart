import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:project_1/models/task.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

// List to hold tasks
class _TaskState extends State<Task> {

  final List<Color> availableColors = [
    Color(0xfff44336),
    Color(0xffff9800),
    Color(0xffffeb3b),
    Color(0xff4caf50),
    Color(0xff2196f3),
    Color(0xff9c27b0)
  ];

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;

  Color cardColor1 = Colors.black;
  Color cardColor2 = Colors.black;
  Color cardColor3 = Colors.black;
  Color cardColor4 = Colors.black;
  Color cardColor5 = Colors.black;

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project 1'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.teal,
        child: SizedBox(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const SizedBox(height: 20),
              Center(child: const Text('Tasks', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                width: 400,
                child: Card(
                  color: cardColor1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10, left: 16),
                              child: Text(
                                'Complete Assignments',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  decoration: isChecked1 ? TextDecoration.lineThrough : null,
                                  decorationColor: Colors.white,
                                  decorationThickness: 2,
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Checkbox(
                              value: isChecked1,
                              onChanged: (value) {
                                setState(() {
                                  isChecked1 = value!;
                                });
                                // if (isChecked1) {
                                //   _firestore.collection('tasks').add({
                                //     'taskName': 'Project 1: Tasks',
                                //     'completed': true,
                                //   });
                                // }
                              }
                            ),
                          ),
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: availableColors.map((color) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (cardColor1 == color) {
                                  cardColor1 = Colors.black;
                                } else {
                                  cardColor1 = color;
                                }
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              color: color,
                            ),
                          );
                        }).toList(),
                      ),
                    ]
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 400,
                child: Card(
                  color: cardColor2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10, left: 16),
                              child: Text(
                                'Call Teacher',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  decoration: isChecked2 ? TextDecoration.lineThrough : null,
                                  decorationColor: Colors.white,
                                  decorationThickness: 2,
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Checkbox(
                              value: isChecked2,
                              onChanged: (value) {
                                setState(() { isChecked2 = value!; });
                              }
                            ),
                          ),
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: availableColors.map((color) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (cardColor2 == color) {
                                  cardColor2 = Colors.black;
                                } else {
                                  cardColor2 = color;
                                }
                              });
                            },
                            child: Container(width: 30, height: 30, margin: EdgeInsets.symmetric(horizontal: 5), color: color),
                          );
                        }).toList(),
                      ),
                    ]
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 400,
                child: Card(
                  color: cardColor3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10, left: 16),
                              child: Text(
                                'Plan Summer Vacation',
                                style: TextStyle(
                                  color: isChecked3 ? Colors.white : Colors.white,
                                  fontSize: 20,
                                  decoration: isChecked3 ? TextDecoration.lineThrough : null,
                                  decorationColor: Colors.white,
                                  decorationThickness: 2,
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Checkbox(
                              value: isChecked3,
                              onChanged: (value) {
                                setState(() { isChecked3 = value!; });
                              }
                            ),
                          ),
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: availableColors.map((color) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (cardColor3 == color) {
                                  cardColor3 = Colors.black;
                                } else {
                                  cardColor3 = color;
                                }
                              });
                            },
                            child: Container(width: 30, height: 30, margin: EdgeInsets.symmetric(horizontal: 5), color: color),
                          );
                        }).toList(),
                      ),
                    ]
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 400,
                child: Card(
                  color: cardColor4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10, left: 16),
                              child: Text(
                                'Graduation Shopping',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  decoration: isChecked4 ? TextDecoration.lineThrough : null,
                                  decorationColor: Colors.white,
                                  decorationThickness: 2,
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Checkbox(
                              value: isChecked4,
                              onChanged: (value) {
                                setState(() { isChecked4 = value!; });
                              }
                            ),
                          ),
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: availableColors.map((color) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (cardColor4 == color) {
                                  cardColor4 = Colors.black;
                                } else {
                                  cardColor4 = color;
                                }
                              });
                            },
                            child: Container(width: 30, height: 30, margin: EdgeInsets.symmetric(horizontal: 5), color: color),
                          );
                        }).toList(),
                      ),
                    ]
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 400,
                child: Card(
                  color: cardColor5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10, left: 16),
                              child: Text(
                                'Graduation Dinner',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  decoration: isChecked5 ? TextDecoration.lineThrough : null,
                                  decorationColor: Colors.white,
                                  decorationThickness: 2,
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Checkbox(
                              value: isChecked5,
                              onChanged: (value) {
                                setState(() { isChecked5 = value!; });
                              }
                            ),
                          ),
                        ]
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: availableColors.map((color) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (cardColor5 == color) {
                                  cardColor5 = Colors.black;
                                } else {
                                  cardColor5 = color;
                                }
                              });
                            },
                            child: Container(width: 30, height: 30, margin: EdgeInsets.symmetric(horizontal: 5), color: color),
                          );
                        }).toList(),
                      ),
                    ]
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.black,
        onPressed:() {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newTaskName = '';
              return AlertDialog(
                title: Text("Add New Task"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: "Task Name"),
                      onChanged: (value) {
                        newTaskName = value;
                      },
                    ),
                  ]),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Add to List"),
                      onPressed: () {
                        setState(() {
                          // isChecked1 = false;
                          // isChecked2 = false;
                          // isChecked3 = false;
                          // isChecked4 = false;
                          // isChecked5 = false;
                        });
                        if (newTaskName.isNotEmpty) {
                          // _firestore.collection('tasks').add({
                            //   'taskName': newTaskName,
                            //   'completed': false,
                            // });
                          // },
                          //     Navigator.of(context).pop());
                        }
                      }
                    )
                  ],
              );
            },
          );
        }
      ),
    );
  }
}
