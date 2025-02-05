import 'package:app/appshell.dart';
import 'package:app/pages/profile.dart';
import 'package:app/pages/signup.dart';
import 'package:app/services/Authentication.dart';
import 'package:app/utils/encryption_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninPage extends StatefulWidget {
  final VoidCallback? onLogin;
  static const nameRoute = '/signinpage';

  SigninPage({this.onLogin});

  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // Controller untuk mengelola input username dan password
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService(); // Instance auth service
  final _formKey = GlobalKey<FormState>();

  void _login() async {
    // Mengambil nilai username dan password dari controller
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // Validasi input tidak boleh kosong
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Memanggil service login dan menangani hasilnya
    final success = await _authService.login(username, password);
    if (success) {
      // Jika login berhasil, enkripsi username dan navigasi ke Dashboard
      final encryptedUsername = EncryptionHelper.encrypt(username);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AppshellPage(),
        ),
      );
    } else {
      // Jika login gagal, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username atau Password salah')),
      );
    }
  }

  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/BAuthentication.jpg"),
                fit: BoxFit.cover
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Sign In', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black,
                          fontFamily: 'montserrat'
                      )),
                      SizedBox(height: 15),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(hintText: 'Masukan username anda', prefixIcon: Icon(Icons.email), prefixIconColor: Colors.blueAccent,  border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.5
                                  )
                              ), enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.5
                                  )
                              ), focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.5
                                  )
                              )),
                              textAlignVertical: TextAlignVertical.center,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukan gmail anda';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0
                              ),
                              controller: _usernameController,
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  hintText: 'Masukan password anda',
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1.5
                                      )
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1.5
                                      )
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 1.5
                                      )
                                  ),
                                  prefixIcon: Icon(Icons.password),
                                  prefixIconColor: Colors.blueAccent
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukan password anda';
                                }
                                return null;
                              },
                              obscureText: true,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0
                              ),
                              controller: _passwordController,
                            ),
                            SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => print('Hallo'),
                                child: Text('Lupa password?', style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                )),
                              ),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _login,
                                child: Text('Login', style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white
                                )),
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                                    shadowColor: WidgetStatePropertyAll(Colors.black),
                                    elevation: WidgetStatePropertyAll(5.0),
                                    padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 10.0))
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: Divider(
                            color: Colors.black,
                            thickness: 1,
                            endIndent: 10,
                          )),
                          Text('Login With'),
                          Expanded(child: Divider(
                            color: Colors.black,
                            thickness: 1,
                            indent: 10,
                          ))
                        ],
                      ),
                      SizedBox(height: 20),
                      RawMaterialButton(
                        onPressed: () => print('hai'),
                        child: Image.asset('assets/icons/google.png', height: 24),
                        fillColor: Colors.white,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(5.0),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Belum punya akun? ', style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                          )),
                          TextButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Signup())),
                            child: Text('Register', style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}