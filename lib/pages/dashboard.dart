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
                              Text('5', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
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
                                Text('50%', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
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
                                Text('15', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
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
            ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  height: 10,
                  color: Colors.white,
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xfff4f4f5),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.check_circle, color: Colors.red),
                                  SizedBox(width: 10),
                                  Text('Jaringan Saraf Tiruan', style: TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                            )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: PopupMenuButton(
                                    icon: Icon(Icons.more_horiz),
                                    onSelected: (String value) {
                                      if (value == "delete") {
                                        print('Delete Success');
                                      }
                                    },
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'profile',
                                        child: Text('Profile'),
                                      ),
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                        Text('Mereview Jurnal', style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        )),
                        Text('Mereview sebuah jurnal yang berkaitan dengan Jaringan Saraf Tiruan alias Neural Network', style: TextStyle(
                          fontSize: 18,
                        ),
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
                                    Text('Today, 23 : 00 WIB')
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
            ),
          ],
        )
      ),
    );
  }
}
