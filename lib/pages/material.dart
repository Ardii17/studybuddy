import 'package:flutter/material.dart';

class MaterialLearningPage extends StatelessWidget {
  static const nameRoute = '/materipage';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material'),
        backgroundColor: Colors.blueAccent,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add, color: Colors.white))
        ],
      ),
      body: Text('Ini adalah halaman Materi'),
    );
  }
}