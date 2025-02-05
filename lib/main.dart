import 'package:app/appshell.dart';
import 'package:app/pages/account.dart';
import 'package:app/pages/all_assignment.dart';
import 'package:app/pages/class.dart';
import 'package:app/pages/dashboard.dart';
import 'package:app/pages/material.dart';
import 'package:app/pages/signin.dart';
import 'package:app/services/NotificationService.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import './pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: Color(0xfff4f4f5)
      ),
      title: 'Study Buddy',
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.nameRoute: (context) => HomePage(),
        AccountPage.nameRoute: (context) => AccountPage(),
        AllAssignmentPage.nameRoute: (context) => AllAssignmentPage(),
        ClassPage.nameRoute: (context) => ClassPage(),
        DashboardPage.nameRoute: (context) => DashboardPage(),
        MaterialLearningPage.nameRoute: (context) => MaterialLearningPage()
      },
    );
  }
}

class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initNotifications();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connected to mobile data");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connected to Wi-Fi");
    } else {
      print("No internet connection");
    }
  }

  Future<void> requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print('Izin notifikasi diberikan');
    } else {
      print('Izin notifikasi ditolak');
    }
  }

  void _initNotifications() async {
    await requestNotificationPermission();
    await _notificationService.init();
  }
  bool _isLoggedIn = false;

  void _login() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  Widget build(BuildContext context) {
    return _isLoggedIn ? AppshellPage() : SigninPage(onLogin: _login);
    // return _isLoggedIn ? SigninPage(onLogin: _login) : SigninPage(onLogin: _login);
  }
}