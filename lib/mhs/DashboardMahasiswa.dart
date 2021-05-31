import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:peterpan_app2/dosen/ListDosen.dart';
import 'package:peterpan_app2/main.dart';
import 'package:peterpan_app2/mhs/FormMhsBuatJadwal.dart';
import 'package:peterpan_app2/mhs/FormPengajuanJanjianMhs.dart';
import 'package:peterpan_app2/mhs/ListJanjianDisetujui.dart';

import '../apiservices.dart';
import '../model.dart';
import 'ListJanjianMahasiswa.dart';

class DashboardMahasiswa extends StatefulWidget {
  final String title;
  final String nim;
  final String namaMhs;
  final String username;
  final String email;

  DashboardMahasiswa({Key key, this.title, this.nim, this.namaMhs, this.username, this.email}) : super(key: key);

  @override
  _DashboardMahasiswaState createState() => _DashboardMahasiswaState(title,nim,namaMhs,username,email);
}

class _DashboardMahasiswaState extends State<DashboardMahasiswa> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  String nim;
  String namaMhs;
  String username;
  String title;
  String email;
  List<Mahasiswa> mahasiswa = new List();
  Mahasiswa mhs = new Mahasiswa();

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  _DashboardMahasiswaState(this.title, this.nim, this.namaMhs, this.username ,this.email);

  bool _isLoggedIn = false;

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
      appBar: AppBar(title: Text("Dashboard Mahasiswa"),
      centerTitle: true,
      ),
      body: FutureBuilder(
        future: apiservices().getMhs(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Mahasiswa>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done)
          {
           mahasiswa = snapshot.data;
           mhs.nim = "72180188";
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
                                        context, MaterialPageRoute(builder: (context) => ListDosen(title: "Buat Jadwal Janjian",)),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.people_sharp, size: 60.0),
                                          Text("Daftar Dosen", style: TextStyle(
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
                                        context, MaterialPageRoute(builder: (context) => ListJanjianMahasiswa(title: "Daftar Pengajuan", nim:mhs.nim)),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.format_list_bulleted, size: 60.0),
                                          Text("Pengajuan Janji", style: TextStyle(
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
                                        context, MaterialPageRoute(builder: (context) => FormMhsBuatJadwal(title: "Buat Jadwal Janjian", nim:mhs.nim)),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.add, size: 60.0),
                                          Text("Ajukan Janjian", style: TextStyle(
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
                                        context, MaterialPageRoute(builder: (context) => ListJanjianDisetujui(title: "Buat Jadwal Janjian", nim:mhs.nim)),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(Icons.verified_outlined, size: 60.0),
                                          Text("Janjian Disetujui", style: TextStyle(
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
