import 'package:app/object/class.dart';
import 'package:app/lib/class_sevices.dart';
import 'package:app/object/dailyclass.dart';
import 'package:app/pages/dailyclass.dart';
import 'package:flutter/material.dart';


class ClassPage extends StatefulWidget {
  static const nameRoute = '/classpage';
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  DateTime today = DateTime.now();
  bool isLoading = true;
  List<Class> allClass = [];
  late List<Dailyclass> _dailyClass = [
    Dailyclass(day: 'Monday', query: 'Senin', classCount: 3),
    Dailyclass(day: 'Tuesday', query: 'Selasa', classCount: 1),
    Dailyclass(day: 'Wednesday', query: 'Rabu', classCount: 1),
    Dailyclass(day: 'Thursday', query: 'Kamis', classCount: 2),
    Dailyclass(day: 'Friday', query: 'Jumat', classCount: 0),
    Dailyclass(day: 'Saturday', query: 'Sabtu', classCount: 3),
    Dailyclass(day: 'Sunday', query: 'Minggu', classCount: 0),
  ];

  @override
  void initState(){
    super.initState();
    fetchData();
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await ClassService.getAllClasses();
      setState(() {
        allClass = response;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

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
        body: isLoading ? Center(
          child: CircularProgressIndicator(
            color: Colors.blueAccent,
            strokeWidth: 4,
          ),
        ) : RefreshIndicator(
            child: Container(
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
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(_dailyClass[today.weekday - 1].day, style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                )),
                              )),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              Text(allClass.where((c) => c.hari == _dailyClass[today.weekday - 1].query).length > 0 ? 'Hari ini terdapat ${allClass.where((c) => c.hari == _dailyClass[today.weekday - 1].query).length} Kelas' : 'Tidak ada kelas hari ini', style: TextStyle(
                                  fontWeight: FontWeight.w600
                              ))
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
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(daily.day, style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                    )),
                                  )),
                                ],
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  Text(allClass.where((c) => c.hari == daily.query).length > 0 ? 'Hari ini terdapat ${allClass.where((c) => c.hari == daily.query).length} Kelas' : 'Tidak ada kelas hari ini', style: TextStyle(
                                      fontWeight: FontWeight.w600
                                  ))
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
            ),
            onRefresh: _refreshData
        )
    );
  }
}
