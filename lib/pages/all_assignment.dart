
import 'package:app/object/assignment.dart';
import 'package:app/pages/form/task_upload_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllAssignmentPage extends StatefulWidget {
  static const nameRoute = '/assignmentpage';
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<AllAssignmentPage> {
  List<Task> _tasks = [];

  void _addTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskFormPage()),
    );

    if (result != null) {
      setState(() {
        _tasks.add(result);
      });
    }
  }

  void _editTask(Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskFormPage(task: task)),
    );

    if (result != null) {
      setState(() {
        final index = _tasks.indexWhere((t) => t.id == task.id);
        _tasks[index] = result;
      });
    }
  }

  void _toggleTaskStatus(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tugas', style: TextStyle(
          color: Colors.white
        )),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(
          Icons.arrow_back_ios_new, color: Colors.white,
        )),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none
              ),
            ),
            subtitle: Text('Deadline: ${DateFormat('dd/MM/yyyy').format(task.deadline)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) => _toggleTaskStatus(task),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editTask(task),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
