import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peterpan_app2/dosen/DashboardDosen.dart';
import 'package:peterpan_app2/dosen/FormRegisterDosen.dart';
import 'package:peterpan_app2/dosen/pie_chart_ring.dart';
import 'package:peterpan_app2/list_janjian_tersedia.dart';
import 'package:peterpan_app2/mhs/DashboardMahasiswa.dart';
import 'package:peterpan_app2/mhs/FormRegisterMahasiswa.dart';
import 'package:peterpan_app2/pengajuan_janjian.dart';
import 'apiservices.dart';
import 'home_screen.dart';
import 'package:peterpan_app2/home_screen.dart';
import 'model.dart';

var assetImage = AssetImage("assets/images/logo.png");
var image = Image(image: assetImage);

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
  String namaUser = "";
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);


  _login() async{
    final googleUser = await GoogleSignIn().signIn();
    for (var model in modelUser)
    {
      if (model.username == googleUser.email) {
        sama = true;
        idUser = model.id;
        namaUser=googleUser.displayName;
        break;
      }

    }
    if(googleUser != null && googleUser.email.contains("si.ukdw.ac.id") && sama == true){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  DashboardDosen(title: "Dashboard Dosen",nidn : idUser, namaDosen: namaUser, username: "", email: "")));

    }
    else if (googleUser != null && googleUser.email.contains("si.ukdw.ac.id") && sama == false)
      {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => FormRegisterDosen(title: "",nidn: "",namaDosen: "",username: googleUser.email)));

      }


     else if(googleUser != null && googleUser.email.contains("gmail.com") && sama == true ){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  DashboardMahasiswa(title: "Dashboard Mahasiswa",nim : idUser, namaMhs: namaUser, username: "", email: "")));
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.tealAccent, Colors.white])
          ),
          child: FutureBuilder(
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
                          padding: const EdgeInsets.only(top: 150.0),
                          child: Center(
                            child: Container(
                              width: 150,
                              height: 200,
                              child: image,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 40,
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
                              'Sign-In With Google',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),


                        SizedBox(
                          height: 500,
                        ),
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
        )
      ),
    );
  }
}
