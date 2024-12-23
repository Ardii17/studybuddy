import 'package:app/object/class.dart';
import 'package:flutter/material.dart';

class TheClass extends StatelessWidget {
  final Class existingClass;

  const TheClass({Key? key, required this.existingClass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back, color: Colors.white)),
        title: Text(existingClass.namaClass, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis, maxLines: 1),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Kelas : ' + existingClass.namaClass),
            Text('Dosen : ' + existingClass.teacher),
            Text('Hari : ' + existingClass.hari),
            Text('Waktu : ' + existingClass.time),
            Text('Keterangan Tugas : ' + existingClass.deskripsi),
          ],
        ),
      ),
    );
  }
}