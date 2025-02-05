import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  static const nameRoute = '/dashboardpage';
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              Text('0', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                              SizedBox(height: 5),
                              Text('Kelas Hari Ini', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white))
                            ],
                          ),
                        )
                      ),
                      Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Text('0%', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                                SizedBox(height: 5),
                                Text('Tugas Selesai', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white))
                              ],
                            ),
                          )
                      ),
                      Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Text('0', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                                SizedBox(height: 5),
                                Text('Materi Dibaca', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white))
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.class_, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Add class', style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500, color: Colors.white
                          ))
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    onTap: () {},
                  )
                ),
                SizedBox(width: 10),
                Expanded(
                    child: GestureDetector(
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.assignment, color: Colors.white),
                            SizedBox(width: 10),
                            Text('Add Assignment', style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500, color: Colors.white
                            ))
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      onTap: () {},
                    )
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(height: 50),
            Center(
              child: Text('Belum ada aktifitas terbaru'),
            )
          ],
        )
      ),
    );
  }
}
