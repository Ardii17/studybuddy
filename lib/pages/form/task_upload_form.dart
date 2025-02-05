// Form Tambah/Edit Tugas
import 'package:app/object/assignment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskFormPage extends StatefulWidget {
  final Task? task;

  const TaskFormPage({Key? key, this.task}) : super(key: key);

  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _deadline;

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _description = widget.task?.description ?? '';
    _deadline = widget.task?.deadline ?? DateTime.now();
  }

  void _selectDeadline() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _deadline) {
      setState(() {
        _deadline = pickedDate;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newTask = Task(
        id: widget.task?.id ?? DateTime.now().toString(),
        title: _title,
        description: _description,
        deadline: _deadline,
      );

      // Misalnya mengirim kembali tugas ke halaman sebelumnya
      Navigator.pop(context, newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Tambah Tugas' : 'Edit Tugas', style: TextStyle(
          color: Colors.white
        )),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(
          Icons.arrow_back_ios_new, color: Colors.white,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Judul Tugas'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan judul tugas';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Deskripsi Tugas'),
                maxLines: 3,
                onSaved: (value) => _description = value!,
              ),
              Row(
                children: [
                  Text('Deadline: ${DateFormat('dd/MM/yyyy').format(_deadline)}'),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _selectDeadline,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: Text('Simpan Tugas', style: TextStyle(
                  color: Colors.white
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}