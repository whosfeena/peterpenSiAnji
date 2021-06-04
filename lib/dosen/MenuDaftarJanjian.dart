import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/dosen/ListJadwalJanjianDosen.dart';
import 'package:peterpan_app2/dosen/ViewAllJanjianDosen.dart';
import 'package:peterpan_app2/dosen/ViewJanjianDosenAll.dart';
import 'package:peterpan_app2/dosen/ViewJanjianReqByMhs.dart';
import 'package:peterpan_app2/dosen/ViewJanjianTersediaByDosen.dart';

import '../apiservices.dart';
import '../model.dart';

class MenuDaftarJanjian extends StatefulWidget {
  String title;
  String kd_janjian;
  String nidn;
  Dosen dosen;

  MenuDaftarJanjian({Key key, this.title, this.nidn, this.dosen }) : super(key: key);

  @override
  _MenuDaftarJanjianState createState() => _MenuDaftarJanjianState(title,nidn,dosen);
}

class _MenuDaftarJanjianState extends State<MenuDaftarJanjian> {
  String title;
  String kd_janjian;
  String nidn;
  Dosen dosen;
  _MenuDaftarJanjianState(this.title, this.nidn, this.dosen);

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: Text("Kategori Janjian")),
        body:Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.list_alt),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Jadwal Janjian yang Anda Buat',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize:15,
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ListJadwalJanjianDosen()),);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAllJanjianDosen(title: "Slot Jadwal Anda",
                        nidn: nidn)),
                  ).then(onGoBack);
                },
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.list_alt,),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Pengajuan Janjian Mahasiswa',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize:15,
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewJanjianReqByMhs(title: "Pengajuan Janjian",
                        nidn: nidn)),
                  ).then(onGoBack);
                },
                )
              ),

            Card(
                child: ListTile(
                  leading: Icon(Icons.list_alt,),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Seluruh Jadwal Janjian',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize:15,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ListJadwalJanjianDosen()),);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewJanjianDosenAll(title: "Daftar Janjian",
                          nidn: nidn)),
                    ).then(onGoBack);
                  },
                )
            ),

            Card(
                child: ListTile(
                  leading: Icon(Icons.list_alt,),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Janjian yang Masih Tersedia',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize:15,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ListJadwalJanjianDosen()),);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewJanjianTersediaByDosen(title: "Slot Janjian Tersedia",
                          nidn: nidn)),
                    ).then(onGoBack);
                  },
                )
            ),
          ],
        ),
    );
  }
}
