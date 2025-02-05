import 'package:app/lib/class_sevices.dart';
import 'package:app/object/class.dart';
import 'package:flutter/material.dart';
import '../../utils/showNotification.dart';

class ClassFormPage extends StatefulWidget {
  // Optional ClassModel for editing, null for adding new class
  final Class? existingClass;
  final int? indexDay;

  const ClassFormPage({Key? key, this.existingClass, this.indexDay}) : super(key: key);

  @override
  _ClassFormPageState createState() => _ClassFormPageState();
}

class _ClassFormPageState extends State<ClassFormPage> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  late TextEditingController _namaClassController;
  late TextEditingController _deskripsiController;
  late TextEditingController _teacherController;

  // Time and day variables
  TimeOfDay? _selectedTime;
  String? _selectedDay;

  // List of days for dropdown
  final List<String> _days = [
    'Senin', 'Selasa', 'Rabu', 'Kamis',
    'Jumat', 'Sabtu', 'Minggu'
  ];

  @override
  void initState() {
    super.initState();

    // Initialize controllers and form values
    _namaClassController = TextEditingController(
        text: widget.existingClass?.namaClass ?? ''
    );
    _deskripsiController = TextEditingController(
        text: widget.existingClass?.deskripsi ?? ''
    );
    _teacherController = TextEditingController(
        text: widget.existingClass?.teacher ?? ''
    );

    // Set initial day if editing
    _selectedDay = widget.existingClass?.hari;

    // Set initial time if editing
    if (widget.existingClass?.time != null) {
      List<String> timeParts = widget.existingClass!.time!.split(':');
      _selectedTime = TimeOfDay(
          hour: int.parse(timeParts[0]),
          minute: int.parse(timeParts[1])
      );
    }
  }

  @override
  void dispose() {
    // Clean up controllers
    _namaClassController.dispose();
    _deskripsiController.dispose();
    _teacherController.dispose();
    super.dispose();
  }

  // Method to show time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Format time as HH:mm:ss
      String formattedTime = _selectedTime != null
          ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}:00'
          : '00:00:00';

      // Determine if it's an add or edit operation
      bool isEditing = widget.existingClass?.id != null;
      Class insertClass = Class(teacher: _teacherController.text.trim(), time: formattedTime, namaClass: _namaClassController.text.trim(), deskripsi: _deskripsiController.text.trim(), hari: _selectedDay!);
      Class updateClass = Class(id: widget.existingClass?.id, teacher: _teacherController.text.trim(), time: formattedTime, namaClass: _namaClassController.text.trim(), deskripsi: _deskripsiController.text.trim(), hari: _selectedDay!);

      try {
        if (isEditing) {
          bool response = await ClassService.updateClass(updateClass);
          _showSuccessDialog();
          if (response) {
            ShowNotification.showTestNotification('Mengedit Kelas', 'Kelas berhasil diedit');
          }
        } else {
          await ClassService.createClass(insertClass);
          ShowNotification.showTestNotification('Menambahkan Kelas', 'Kelas berhasil dibuat');
          _showSuccessDialog();
        }

      } catch (e) {
        print(e);
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Berhasill'),
          content: Text(widget.existingClass != null ? "Kelas telah dirubah" : 'Kelas baru telah ditambahkan.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
                Navigator.of(context).pop(); // Go back to previous screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.existingClass == null
                ? 'Tambah Kelas Baru'
                : 'Edit Kelas',
           style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Nama Kelas TextField
              TextFormField(
                controller: _namaClassController,
                decoration: InputDecoration(
                  labelText: 'Nama Kelas',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.class_),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama kelas harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Deskripsi TextField
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi (Opsional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),

              // Hari Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Pilih Hari',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                value: _selectedDay ?? _days[widget.indexDay!],
                items: _days.map((String day) {
                  return DropdownMenuItem(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDay = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Silakan pilih hari';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Teacher TextField
              TextFormField(
                controller: _teacherController,
                decoration: InputDecoration(
                  labelText: 'Nama Guru',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama guru harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Time Picker
              GestureDetector(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Waktu Kelas',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  child: Text(
                    _selectedTime == null
                        ? 'Pilih Waktu'
                        : _selectedTime!.format(context),
                    style: TextStyle(
                      color: _selectedTime == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.existingClass == null
                      ? 'Tambah Kelas'
                      : 'Update Kelas',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}