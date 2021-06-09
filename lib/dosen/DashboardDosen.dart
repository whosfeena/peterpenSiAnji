import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peterpan_app2/dosen/DosenAddJadwalJanjian.dart';
import 'package:peterpan_app2/dosen/DosenVerifikasi.dart';
import 'package:peterpan_app2/dosen/ListDosen.dart';
import 'package:peterpan_app2/dosen/ListJadwalJanjianDosen.dart';
import 'package:peterpan_app2/dosen/pie_chart_ring.dart';
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
            dsn.nidn = nidn;
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
                                        context, MaterialPageRoute(builder: (context) => DosenAddJadwalJanjian(title: "Tambah Jadwal Janjian", nidn:dsn.nidn)),
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
                                        context, MaterialPageRoute(builder: (context) => piechart(title: "Grafik Janjian Anda", nidn:dsn.nidn)),
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
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/icon_orang.png'),
                          fit: BoxFit.fill),
                        )
                      ),
                    Text(namaDosen, style: TextStyle(fontSize: 16,color: Colors.white),),
                    Padding(padding: EdgeInsets.all(1.0)),
                    Text(nidn, style: TextStyle(fontSize: 10,color: Colors.white),),
                  ],
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
