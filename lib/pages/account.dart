import 'package:app/pages/signin.dart';
import 'package:app/services/Authentication.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  static const nameRoute = '/accountpage';
  var _authService = AuthService();

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
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/Ardi.png'),
                      radius: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Muhammad Ardiansyah Firdaus', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )),
                    Text('Mahasiswa', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white
                    ))
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 0.5),
                        spreadRadius: 0,
                        blurRadius: 2,
                      )
                    ]
                ),
                child: Column(
                  children: [
                    Text('Settings', style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    )),
                    SizedBox(height: 15),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.dark_mode),
                          SizedBox(width: 10),
                          Expanded(child: Text('Dark Mode', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ))),
                          SizedBox(width: 5),
                          Switch(value: false, onChanged: (value) {})
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.account_circle),
                          SizedBox(width: 10),
                          Expanded(child: Text('Account', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ))),
                          SizedBox(width: 5),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.notifications),
                          SizedBox(width: 10),
                          Expanded(child: Text('Notification', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ))),
                          SizedBox(width: 5),
                          Row(
                            children: [
                              Text('Ya', style: TextStyle(fontSize: 18)),
                              SizedBox(width: 10),
                              Icon(Icons.keyboard_arrow_right)
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.lock),
                          SizedBox(width: 10),
                          Expanded(child: Text('Privacy', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ))),
                          SizedBox(width: 5),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.help),
                          SizedBox(width: 10),
                          Expanded(child: Text('Help', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ))),
                          SizedBox(width: 5),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.info),
                          SizedBox(width: 10),
                          Expanded(child: Text('About', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ))),
                          SizedBox(width: 5),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        await _authService.logout();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 10),
                          Expanded(child: Text('Logout', style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ))),
                          SizedBox(width: 5),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}