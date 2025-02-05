import 'package:app/pages/all_assignment.dart';
import 'package:app/pages/class.dart';
import 'package:app/pages/dailyclass.dart';
import 'package:app/pages/material.dart';
import 'package:app/services/NotificationService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  static const nameRoute = '/homepage';
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final NotificationService _notificationService = NotificationService();
  DateTime today = DateTime.now();
  String _description = "";
  double _temperature = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWeather('Bandung');
  }

  Future<void> _getWeather(String city) async {
    final apiKey = '8892487e917244de92f100837243110'; // Ganti dengan API key Anda
    final url =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _description = data['current']['condition']['text'];
          _temperature = data['current']['temp_c']; // Suhu dalam Celsius
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      setState(() {
        _description = "";
        _temperature = 0.0;
      });
    }
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            color: Colors.blueAccent
          ),
        ),
        ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 55),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Center(
                          child: Image.asset('assets/icons/studybuddy.png'),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(width: 10),
                      Text('Study Buddy', style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ))
                    ],
                  ),
                ),
                SizedBox(width: 5),
                IconButton(onPressed: () {}, icon: Icon(Icons.notifications_active, color: Colors.white))
              ],
            ),
            SizedBox(height: 10),
            Text('Hello, Selamat Datang Ardiansyah', style: TextStyle(color: Colors.white)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(1, 2)
                    )
                  ]
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff4f4f5),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ClipRRect(
                        child: Image.asset('assets/images/Ardi.png', height: 100),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(_temperature > 27 ? Icons.sunny : Icons.cloud, color: _temperature > 27 ? Colors.orangeAccent : Colors.lightBlueAccent),
                              SizedBox(width: 5),
                              Text('${_temperature!.toStringAsFixed(1)} °C')
                            ],
                          )
                        ),
                        Text('Ardiansyah', style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600
                        )),
                        Text('Mahasiswa', style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text('Semangat Belajarnya Ya!!!'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, ClassPage.nameRoute),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(1, 2)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/icons/kelas.png', height: 50),
                              SizedBox(height: 2),
                              Text('Class', style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ))
                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, MaterialLearningPage.nameRoute),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(1, 2)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/icons/materi.png', height: 50),
                              SizedBox(height: 2),
                              Text('Material', style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ))
                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AllAssignmentPage.nameRoute),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(1, 2)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/icons/tugas.png', height: 50),
                              SizedBox(height: 2),
                              Text('Assignment', style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ))
                            ],
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DailyclassPage(classId: today.weekday - 1))),
              child: Container(
                padding: EdgeInsets.all(10),
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/today.png'),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(1, 2)
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage('assets/images/assignment.png'),
                      fit: BoxFit.cover
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(1, 2)
                    )
                  ]
              ),
            ),
          ],
        ),
      ],
    );
  }
}