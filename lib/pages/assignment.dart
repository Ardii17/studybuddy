import 'package:flutter/material.dart';

class AssignmentPage extends StatefulWidget {
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<AssignmentPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('Mereview Jurnal', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}