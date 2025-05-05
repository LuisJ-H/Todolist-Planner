import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
<<<<<<< Updated upstream
  @override
  Widget build(BuildContext context) {
    return Container();
=======
  bool _isEditing = false;

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

  Color cardColor1 = Colors.blueAccent;
  Color cardColor2 = Colors.blueAccent;
  Color cardColor3 = Colors.blueAccent;
  Color cardColor4 = Colors.blueAccent;
  Color cardColor5 = Colors.blueAccent;

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: 400,
                child: Card(
                  color: cardColor1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Complete Assignments',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Checkbox(
                              value: isChecked1,
                              onChanged: (bool? value) {
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
                                cardColor1 = color;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.symmetric(horizontal: 5),
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Call Teacher',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Checkbox(
                              value: isChecked2,
                              onChanged: (bool? value) {
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
                              setState(() { cardColor2 = color; });
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Plan Summer Vacation',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Checkbox(
                              value: isChecked3,
                              onChanged: (bool? value) {
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
                              setState(() { cardColor3 = color; });
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Graduation Shopping',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Checkbox(
                              value: isChecked4,
                              onChanged: (bool? value) {
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
                              setState(() { cardColor4 = color; });
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Graduation Dinner',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Checkbox(
                              value: isChecked5,
                              onChanged: (bool? value) {
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
                              setState(() { cardColor5 = color; });
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
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
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

                        });
                        if (newTaskName.isNotEmpty) {
                          // _firestore.collection('tasks').add({
                          //   'taskName': newTaskName,
                          //   'completed': false,
                          // });
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
            },
          );
        }
      ),
    );
>>>>>>> Stashed changes
  }
}
