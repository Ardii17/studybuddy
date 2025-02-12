import 'dart:async';
import 'package:app/pages/form/class.dart';
import 'package:app/pages/the_class.dart';
import 'package:app/lib/class_sevices.dart';
import 'package:app/object/class.dart';
import 'package:app/object/dailyclass.dart';
import 'package:app/utils/deleteConfirmationDialog.dart';
import 'package:flutter/material.dart';
import '../utils/showNotification.dart';


class DailyclassPage extends StatefulWidget {
  final int classId;
  const DailyclassPage({Key? key, required this.classId}) : super(key: key);
  _DailyclassPageState createState() => _DailyclassPageState();
}

class _DailyclassPageState extends State<DailyclassPage> {
  late List<Dailyclass> _dailyClass = [
    Dailyclass(day: 'Monday', query: 'Senin', classCount: 3),
    Dailyclass(day: 'Tuesday', query: 'Selasa', classCount: 1),
    Dailyclass(day: 'Wednesday', query: 'Rabu', classCount: 1),
    Dailyclass(day: 'Thursday', query: 'Kamis', classCount: 2),
    Dailyclass(day: 'Friday', query: 'Jumat', classCount: 0),
    Dailyclass(day: 'Saturday', query: 'Sabtu', classCount: 3),
    Dailyclass(day: 'Sunday', query: 'Minggu', classCount: 0),
  ];
  List<Class> allClass = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulasi waktu untuk fetch data
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var data = await ClassService.getClassesByDay(_dailyClass[widget.classId].query!);
      setState(() {
        allClass = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        allClass = [];
        isLoading = false;
      });
    }
  }

  Future<void> deleteData(int id) async {
    try {
      bool response = await ClassService.deleteClass(id);
      if (response) {
        _showSuccessDialog();
        ShowNotification.showTestNotification('Menghapus Kelas', 'Kelas berhasil dihapus');
      }
    } catch (e) {
      print(e);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Berhasill'),
          content: Text("Kelas telah dihapus"),
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _dailyClass[widget.classId].day,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            // onPressed: addOneClass,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ClassFormPage(indexDay: widget.classId))),
            icon: Icon(Icons.add, color: Colors.white),
          )
        ],
      ),
      body: isLoading ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
          strokeWidth: 4,
        ),
      ) : RefreshIndicator(child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: allClass.length > 0 ? ListView.separated(
          padding: const EdgeInsets.all(10),
          separatorBuilder: (context, index) => Divider(
            height: 10,
            color: Colors.white,
          ),
          itemCount: allClass.length,
          itemBuilder: (context, index) {
            Class daily = allClass[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TheClass(existingClass: daily),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xfff4f4f5),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              daily.namaClass,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: PopupMenuButton(
                              icon: Icon(Icons.more_horiz),
                              onSelected: (String value) {
                                if (value == "delete") {
                                  DeleteConfirmationDialog.show(
                                    context: context,
                                    title: 'Hapus Item',  // Opsional
                                    content: 'Apakah Anda yakin ingin menghapus kelas ini?',  // Opsional
                                    onDelete: () {
                                      deleteData(daily.id!);
                                      // Tampilkan snackbar sebagai feedback
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Item berhasil dihapus'),
                                          backgroundColor: Colors.blueAccent,
                                        ),
                                      );
                                    },
                                  );
                                } else if (value == "edit") {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ClassFormPage(existingClass: daily)));
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      daily.teacher,
                      style: TextStyle(fontSize: 18),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(Icons.access_time_outlined),
                                SizedBox(width: 10),
                                Text('${daily.hari}, ${daily.time} WIB')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        ) : Center(
          child: Text('Tidak ada kelas', style: TextStyle(
            fontWeight: FontWeight.w600
          )),
        ),
      ), onRefresh: _refreshData)
    );
  }
}
