import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:peterpan_app2/dosen/DosenAddJadwalJanjian.dart';
import 'package:peterpan_app2/dosen/FormRegisterDosen.dart';
import 'package:peterpan_app2/dosen/ListDosen.dart';
import 'package:peterpan_app2/dosen/ListJadwalJanjianDosen.dart';
import 'package:peterpan_app2/mhs/FormMhsBuatJadwal.dart';
import 'package:peterpan_app2/mhs/FormPengajuanJanjianMhs.dart';
import 'package:peterpan_app2/mhs/FormRegisterMahasiswa.dart';
import 'dosen/DashboardDosen.dart';
import 'package:peterpan_app2/apiservices.dart';


import 'dosen/ViewJadwalJanjianDosen.dart';
import 'mhs/DashboardMahasiswa.dart';
import 'model.dart';


void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardDosen(),
    );
  }
}

class LoginPage extends StatefulWidget {
  String title;
  String username;
  String role;
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;
  String title;
  String username;
  String role;
  UserGoogle google = new UserGoogle();
  List<UserGoogle> gle = new List();

  bool validate = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);


  _login() async{
    final googleUser = await GoogleSignIn().signIn();

    if(googleUser != null && googleUser.email.contains("si.ukdw.ac.id")){
      UserGoogle google = new UserGoogle();
      google.username = googleUser.email;
      google.role = "0";
     String valid ;
valid = get(apiservices().validate(googleUser.email,"0")).toString();

  if(valid == "true")
    {

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>
              DashboardDosen(namaDosen: googleUser.displayName,
                  email: googleUser.email)));
    }
  else
    {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>
              FormRegisterDosen()));

    }
     /* apiservices().validate(googleUser.email,"0").then((isSuccess){
      if (isSuccess == true)
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>
                  DashboardDosen(namaDosen: googleUser.displayName,
                      email: googleUser.email)));
        }
      else
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>
                  FormRegisterDosen()));
        }


      });
*/




    } else if(googleUser != null && googleUser.email.contains("gmail.com")){
      UserGoogle google = new UserGoogle();
      google.username = googleUser.email;
      google.role = "1";

      apiservices().validateUser(googleUser.email).then((isSuccess){
        if(isSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>
                  DashboardMahasiswa(
                    namaMhs: googleUser.displayName, email: googleUser.email,)));
        }
        else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>
                  FormRegisterMahasiswa()));
        }
      });


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
        body: SingleChildScrollView(
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
                      hintText: 'Masukkan Password'),
                ),
              ),
              FlatButton(
                onPressed: (){
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
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
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
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
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
        ),
      ),
    );
  }
}

