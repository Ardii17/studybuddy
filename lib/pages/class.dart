import 'package:app/lib/mysql.dart';
import 'package:app/object/dailyclass.dart';
import 'package:app/pages/dailyclass.dart';
import 'package:app/pages/form/class.dart';
import 'package:flutter/material.dart';

class ClassPage extends StatelessWidget {
  static const nameRoute = '/classpage';
  DateTime today = DateTime.now();
  List<Map<String, dynamic>> allClass = [];
  late List<Dailyclass> _dailyClass = [
    Dailyclass(day: 'Monday', classCount: 3),
    Dailyclass(day: 'Tuesday', classCount: 1),
    Dailyclass(day: 'Wednesday', classCount: 1),
    Dailyclass(day: 'Thursday', classCount: 2),
    Dailyclass(day: 'Friday', classCount: 0),
    Dailyclass(day: 'Saturday', classCount: 3),
    Dailyclass(day: 'Sunday', classCount: 0),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Class'),
            backgroundColor: Colors.blueAccent,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
            leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white
          ),
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Todays', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      )),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DailyclassPage(classId: today.weekday - 1))),
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
                            child: Text(_dailyClass[today.weekday - 1].day, style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500
                            )),
                          )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: PopupMenuButton(
                                  icon: Icon(Icons.more_horiz),
                                  onSelected: (String value) async {
                                    if (value == "delete") {
                                      print('Delete Success');
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                    PopupMenuItem<String>(
                                      value: 'profile',
                                      child: Text('Profilee'),
                                    ),
                                  ],
                                )
                            ),
                          )
                        ],
                      ),

                      Text('Mereview sebuah jurnal yang berkaitan dengan Jaringan Saraf Tiruan alias Neural Network lalu juga sertakan referensi jurnal yang dipakai', style: TextStyle(
                          fontSize: 18
                      ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis),
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
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('All Class', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      )),
                    ),
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
                itemCount: _dailyClass.length,
                itemBuilder: (context, index) {
                  var daily = _dailyClass[index];

                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DailyclassPage(classId: index))),
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
                                child: Text(daily.day, style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                )),
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

                          Text('Mereview sebuah jurnal yang berkaitan dengan Jaringan Saraf Tiruan alias Neural Network lalu juga sertakan referensi jurnal yang dipakai', style: TextStyle(
                              fontSize: 18
                          ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis),
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
              )
            ],
          ),
        )
    );
  }
}