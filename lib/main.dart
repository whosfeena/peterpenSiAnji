import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peterpan_app2/dosen/DashboardDosen.dart';
import 'package:peterpan_app2/dosen/FormRegisterDosen.dart';
import 'package:peterpan_app2/list_janjian_tersedia.dart';
import 'package:peterpan_app2/mhs/DashboardMahasiswa.dart';
import 'package:peterpan_app2/mhs/FormRegisterMahasiswa.dart';
import 'package:peterpan_app2/pengajuan_janjian.dart';
import 'apiservices.dart';
import 'home_screen.dart';
import 'package:peterpan_app2/home_screen.dart';


import 'model.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;
  List<UserGoogle> modelUser = new List();
  bool sama = false;
  String idUser = "";
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);


  _login() async{
    final googleUser = await GoogleSignIn().signIn();
    for (var model in modelUser)
    {
      if (model.username == googleUser.email) {
        sama = true;
        idUser = model.id;
        break;
      }

    }
    if(googleUser != null && googleUser.email.contains("si.ukdw.ac.id") && sama == true){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  DashboardDosen(title: "Dashboard Dosen",nidn : idUser, namaDosen: "", username: "", email: "")));

    }
    else if (googleUser != null && googleUser.email.contains("si.ukdw.ac.id") && sama == false)
      {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => FormRegisterDosen(title: "",nidn: "",namaDosen: "",username: googleUser.email)));

      }


     else if(googleUser != null && googleUser.email.contains("gmail.com") && sama == true ){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  DashboardMahasiswa(title: "Dashboard Mahasiswa",nim : idUser, namaMhs: "", username: "", email: "")));
    }

     else if(googleUser != null && googleUser.email.contains("gmail.com") && sama == false )
       {
       Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (context) => FormRegisterMahasiswa(title: "",nim: "",namaMhs: "",username: googleUser.email)));
       }

  }

  _logout() async{
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: apiservices().getUser(),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserGoogle>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error.toString()}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                modelUser = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Center(
                          child: Container(
                              width: 200,
                              height: 150,
                              /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                              child: Image.network('')),
                        ),
                      ),
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'E-mail',
                              hintText: 'Masukkan Email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Masukkan Password',),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          //TODO FORGOT PASSWORD SCREEN GOES HERE
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.blue, fontSize: 11),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: FlatButton(
                          onPressed: () {
                            _login();
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Or'),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: FlatButton(
                          onPressed: () {
                            _login();
                          },
                          child: Text(
                            'Sign-In With Google >',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Text('New User? Create Account')
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        ),
      ),
    );
  }
}
