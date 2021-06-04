import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peterpan_app2/dosen/DosenAddJadwalJanjian.dart';
import 'package:peterpan_app2/dosen/DosenVerifikasi.dart';
import 'package:peterpan_app2/dosen/DosenViewGrafik.dart';
import 'package:peterpan_app2/dosen/ListDosen.dart';
import 'package:peterpan_app2/dosen/ListJadwalJanjianDosen.dart';
import 'package:peterpan_app2/main.dart';
import 'package:peterpan_app2/mhs/ListJanjianDisetujui.dart';

import '../apiservices.dart';
import '../model.dart';
import 'MenuDaftarJanjian.dart';

class DashboardDosen extends StatefulWidget {
  final String title;
  final String nidn;
  final String namaDosen;
  final String username;
  final String email;
  DashboardDosen({Key key, this.title, this.nidn, this.namaDosen, this.username, this.email}) : super(key: key);

  @override
  _DashboardDosenState createState() => _DashboardDosenState(title,nidn,namaDosen,username,email);
}

class _DashboardDosenState extends State<DashboardDosen> {
  String nidn;
  String namaDosen;
  String username;
  String title;
  String email;
  bool _isLoggedIn = false;
  List<Dosen> dosen = new List();
  Dosen dsn = new Dosen();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _DashboardDosenState(this.title, this.nidn, this.namaDosen, this.username ,this.email);

  _logout() async{
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    //style
    var cardTextStyle = TextStyle(fontFamily: "Montserrat Regular", fontSize: 14, color: Color.fromRGBO(
        135, 18, 224, 1.0));

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard Dosen"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: apiservices().getDosen(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Dosen>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done)
          {
            dosen = snapshot.data;
            dsn.nidn = "1234567891";
            return Stack(
              children: <Widget>[
                Container(
                  height: size.height * .3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/images/top_header.png')
                    ),
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding:  EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: GridView.count(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              primary: false,
                              children: <Widget>[
                                Card(
                                  margin:EdgeInsets.all(2.0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => MenuDaftarJanjian(title: "Jadwal Janjian Dosen", nidn:dsn.nidn)),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.list_alt_outlined, size: 60.0),
                                          Text("Daftar Konsultasi", style: TextStyle(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Card(
                                  margin:EdgeInsets.all(2.0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => DosenAddJadwalJanjian(title: "Daftar Pengajuan", nidn:dsn.nidn)),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.add, size: 60.0),
                                          Text("Tambah Jadwal", style: TextStyle(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Card(
                                  margin:EdgeInsets.all(2.0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => DosenVerifikasi(title: "Janjian Menunggu", nidn:dsn.nidn)),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.verified_outlined, size: 60.0),
                                          Text("Verifikasi Janjian", style: TextStyle(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Card(
                                  margin:EdgeInsets.all(2.0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => DosenViewGrafik(title: "Grafik Janjian Anda")),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.graphic_eq_outlined, size: 60.0),
                                          Text("Grafik Janjian", style: TextStyle(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              crossAxisCount: 3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 140,
              child: DrawerHeader(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  <Widget>[
                    /*CircleAvatar(
                      radius: 30,
                   //   backgroundImage: NetworkImage('https://ssat.ukdw.ac.id/_photos/informasi/72180194.jpg'),
                    ),*/
                    SizedBox(width: 16,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Dycha Rizky', style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.white, fontSize: 16),),
                        Text('72180194', style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.white, fontSize: 14),),
                        Text('dycha@gmail.com', style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.white, fontSize: 12),),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('LOGOUT'),
              onTap: () {
                _logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
