import 'dart:io';
import 'package:app/object/pdf_model.dart';
import 'package:app/pages/material.dart';
import 'package:app/services/pdf_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfUploadForm extends StatefulWidget {
  @override
  _PdfUploadFormState createState() => _PdfUploadFormState();
}

class _PdfUploadFormState extends State<PdfUploadForm> {
  final TextEditingController _judulController = TextEditingController();
  final PdfService _pdfService = PdfService();
  File? _selectedFile;

  Future<void> _pickFile() async {
    // Minta izin terlebih dahulu
    var status = await Permission.storage.request();
    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    }
  }

  void _submitForm() {
    if (_judulController.text.isNotEmpty && _selectedFile != null) {
      // Buat model PDF dan tambahkan ke service
      PdfModel newPdf = PdfModel(
          judul: _judulController.text,
          file: _selectedFile!
      );

      _pdfService.addPdf(newPdf);

      // Reset form
      _judulController.clear();
      setState(() {
        _selectedFile = null;
      });

      // Tampilkan konfirmasi
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF Berhasil Ditambahkan'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload PDF'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              // Navigasi ke halaman daftar PDF
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MaterialLearningPage()
                  )
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                labelText: 'Judul PDF',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickFile,
              icon: Icon(Icons.upload_file),
              label: Text('Pilih File PDF'),
            ),
            SizedBox(height: 16),
            if (_selectedFile != null)
              Text('File Terpilih: ${_selectedFile!.path.split('/').last}'),
            Spacer(),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}