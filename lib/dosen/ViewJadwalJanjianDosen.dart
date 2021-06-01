import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/dosen/ListJadwalJanjianDosen.dart';
import 'package:peterpan_app2/dosen/ViewAllJanjianDosen.dart';
import 'package:peterpan_app2/dosen/ViewJanjianDosenAll.dart';
import 'package:peterpan_app2/dosen/ViewJanjianReqByMhs.dart';

import '../apiservices.dart';
import '../model.dart';

class ViewJadwalJanjianDosen extends StatefulWidget {
  String title;
  String kd_janjian;
  String nidn;
  Dosen dosen;

  ViewJadwalJanjianDosen({Key key, this.title, this.nidn, this.dosen }) : super(key: key);

  @override
  _ViewJadwalJanjianDosenState createState() => _ViewJadwalJanjianDosenState(title,nidn,dosen);
}

class _ViewJadwalJanjianDosenState extends State<ViewJadwalJanjianDosen> {
  String title;
  String kd_janjian;
  String nidn;
  Dosen dosen;
  _ViewJadwalJanjianDosenState(this.title, this.nidn, this.dosen);

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: Text("Daftar Dosen")),
        body:Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.list_alt),
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Slot Jadwal Janjian Anda',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize:15,
                        fontWeight: FontWeight.bold)),
                subtitle: Text('Daftar jadwal yang telah anda buat',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.teal,
                        fontSize:11)),
                onTap: () {
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ListJadwalJanjianDosen()),);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAllJanjianDosen(title: "Jadwal Janjian Dosen",
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
                subtitle: Text('Daftar jadwal yang diajukan oleh mahasiswa',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize:11),),
                onTap: () {
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ListJadwalJanjianDosen()),);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewJanjianReqByMhs(title: "Jadwal Janjian Dosen",
                        nidn: nidn)),
                  ).then(onGoBack);
                },
                )
              ),

            Card(
                child: ListTile(
                  leading: Icon(Icons.list_alt,),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Lihat Seluruh Jadwal Janjian',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize:15,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Menampilkan seluruh jadwal yang ditolak, diterima, dan masih menunggu.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize:11),
                  ),
                  onTap: () {
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ListJadwalJanjianDosen()),);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewJanjianDosenAll(title: "Jadwal Janjian Dosen",
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
