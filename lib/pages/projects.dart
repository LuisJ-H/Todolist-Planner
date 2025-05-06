import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist_app/pages/welcome.dart';
import 'package:todolist_app/pages/task.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final TextEditingController _projectController = TextEditingController();

  final List<Color> blueColors = [
    Color(0xAB64AFDF),
    Color(0xC243BCE6),
    Color(0xFF87CEFA),
    Color(0x780000FF),
    Color(0xDC000080),
  ];

  Color selectedColor = Color(0x786495ED);

  void _showAddProjectDialog() {
    _projectController.clear();
    selectedColor = blueColors.isNotEmpty ? blueColors[0] : Colors.blue;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateInsideDialog) {
          return AlertDialog(
            title: const Text('Add Project'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _projectController,
                    decoration: const InputDecoration(
                      hintText: 'Enter project name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Choose a color:"),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: blueColors.map((color) {
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
                onPressed: () {
                  _projectController.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final name = _projectController.text.trim();
                  final uid = FirebaseAuth.instance.currentUser!.uid;

                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a project name.'),
                      ),
                    );
                    return;
                  }

                  try {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('projects')
                        .add({
                      'projectName': name,
                      'color': selectedColor.value,
                      'createdAt': Timestamp.now(),
                    });

                    _projectController.clear();
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to add project: $e")),
                    );
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  void dispose() {
    _projectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 132, 255),
        title: const Text("Your Projects:"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProjectDialog,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('projects')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Tap + to add a new project.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          final projects = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              final projectName = project['projectName'];
              final projectColor = Color(project['color']);
              final textColor =
                  ThemeData.estimateBrightnessForColor(projectColor) ==
                          Brightness.dark
                      ? Colors.white
                      : Colors.black;

              return Dismissible(
                key: Key(project.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child:
                      const Icon(Icons.delete, color: Colors.white, size: 30),
                ),
                confirmDismiss: (_) async {
                  return await _showConfirmationDialog(context, projectName);
                },
                onDismissed: (_) async {
                  await project.reference.delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$projectName has been deleted.')),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: projectColor,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(
                      projectName,
                      style: TextStyle(fontSize: 20, color: textColor),
                    ),
                    subtitle: Text(
                      "ds",
                      style: TextStyle(color: textColor.withOpacity(0.7)),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      final uid = FirebaseAuth.instance.currentUser!.uid;
                      final projectId = project.id;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Task(
                            uid: uid,
                            projectId: projectId,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool> _showConfirmationDialog(
      BuildContext context, String projectName) async {
    return (await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content:
                  Text('Do you want to delete the project "$projectName"?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        )) ??
        false;
  }
}
