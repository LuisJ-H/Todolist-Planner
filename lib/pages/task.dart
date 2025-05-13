import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Task extends StatefulWidget {
  final String projectId;

  const Task({super.key, required this.projectId});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final List<Color> taskColors = [
    Color(0xFFF06292),
    Color(0xFF64B5F6),
    Color(0xFFAED581),
    Color(0xFFFFB74D),
    Color(0xFFBA68C8),
  ];

  Color selectedColor = Color(0xFF64B5F6);
  String projectName = "";

  @override
  void initState() {
    super.initState();
    _loadProjectName();
  }

  Future<void> _loadProjectName() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects')
        .doc(widget.projectId)
        .get();

    setState(() {
      projectName = doc['projectName'] ?? 'Project';
    });
  }

  Future<void> _addTask(String title, String description) async {
    if (title.trim().isEmpty) return;

    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .add({
      'taskTitle': title,
      'description': description,
      'completed': false,
      'color': selectedColor.value,
      'createdAt': Timestamp.now(),
    });

    _taskController.clear();
    _descController.clear();

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task added!')),
    );
  }

  Future<void> _toggleComplete(DocumentSnapshot taskDoc) async {
    final current = taskDoc['completed'] as bool;
    await taskDoc.reference.update({'completed': !current});
  }

  Future<void> _deleteTask(DocumentSnapshot taskDoc) async {
    await taskDoc.reference.delete();
  }

  void _showAddTaskDialog() {
    _taskController.clear();
    _descController.clear();
    selectedColor = taskColors[0];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateInsideDialog) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      hintText: 'Enter task title',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descController,
                    decoration: const InputDecoration(
                      hintText: 'Enter description (optional)',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Choose a color:"),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: taskColors.map((color) {
                      final isSelected = selectedColor == color;
                      return GestureDetector(
                        onTap: () {
                          setStateInsideDialog(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(width: 3, color: Colors.black)
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () =>
                    _addTask(_taskController.text, _descController.text),
                child: const Text('Add'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final tasksRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects')
        .doc(widget.projectId)
        .collection('tasks')
        .orderBy('createdAt', descending: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(projectName.isNotEmpty ? projectName : 'Loading...'),
        backgroundColor: const Color.fromARGB(255, 0, 132, 255),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: tasksRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Tap + to add a new task.'));
          }

          final tasks = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final title = task['taskTitle'];
              final desc = task['description'] ?? '';
              final completed = task['completed'];
              final color = Color(task['color'] ?? 0xFFFFFFFF);

              final textColor =
                  ThemeData.estimateBrightnessForColor(color) == Brightness.dark
                      ? Colors.white
                      : Colors.black;

              return Dismissible(
                key: Key(task.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => _deleteTask(task),
                child: Card(
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Checkbox(
                      value: completed,
                      onChanged: (_) => _toggleComplete(task),
                    ),
                    title: Text(
                      title,
                      style: TextStyle(
                        decoration: completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: desc.isNotEmpty
                        ? Text(
                            desc,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: textColor.withOpacity(0.7),
                            ),
                          )
                        : null,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
