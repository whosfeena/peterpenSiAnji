import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/mhs/FormPengajuanJanjianMhs.dart';
import 'package:peterpan_app2/model.dart';

import '../apiservices.dart';

class ListJadwalJanjianDosen extends StatefulWidget {

  final String title;
  Janjian janjian;
  String kd_janjian;
  String nidn;

  ListJadwalJanjianDosen({Key key, @required this.title, @required this.nidn, @required this.kd_janjian}) : super(key: key);

  @override
  _ListJadwalJanjianDosenState createState() => _ListJadwalJanjianDosenState(title, kd_janjian, nidn);
}

class _ListJadwalJanjianDosenState extends State<ListJadwalJanjianDosen> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  final String title;
  final String kd_janjian;
  final String nidn;
  bool _isLoading = false;
  List<Janjian> janjian = new List();
  List<Dosen> dosen = new List();
  List<Mahasiswa> mhs = new List();

  _ListJadwalJanjianDosenState(this.title, this.kd_janjian, this.nidn);

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Jadwal Janjian Dosen")),
      body: FutureBuilder(
        future: apiservices().viewJanjianbyNidn(nidn),
        builder:
            (BuildContext context, AsyncSnapshot<List<Janjian>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            janjian = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, position) {
                return Card(
                    margin: new EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 3.0),
                    child: Container(
                      child: ListTile(
                        title: Text(
                            "Kode Janjian : " + janjian[position].kd_janjian,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize:15,
                                fontWeight: FontWeight.bold)
                        ),
                        subtitle: Text("Tanggal : " + janjian[position].tgl + "\nJam : " + janjian[position].jam.toString() + "\nTersedia"
                        ),
                        leading: Icon(Icons.calendar_today_sharp),
                        trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                        onTap: () {
                          showDialog(
                            context: context,
                              builder: (_) => new AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    OutlineButton(
                                      child: Text("Pilih Jadwal"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => FormPengajuanJanjianMhs(title:"Form Pengajuan Janjian",
                                              janjian:janjian[position])),
                                        ).then(onGoBack);
                                      },
                                    ),
                                  ]
                              )
                          ),
                          );
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FormPengajuanJanjianMhs()),);
                        },
                      ),
                    )
                );
              },
              itemCount: janjian.length,
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
