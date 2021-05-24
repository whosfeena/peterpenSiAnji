import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/mhs/FormPengajuanJanjianMhs.dart';
import 'package:peterpan_app2/model.dart';

import '../apiservices.dart';

class ListJadwalJanjianDosen extends StatefulWidget {
  ListJadwalJanjianDosen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListJadwalJanjianDosenState createState() => _ListJadwalJanjianDosenState();
}

class _ListJadwalJanjianDosenState extends State<ListJadwalJanjianDosen> {
  final _formKey = GlobalKey<FormState>();
  List<Janjian> janjian = new List();

  String get nidn => null;

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Jadwal Janjian Dosen")),
      body: FutureBuilder(
        future: apiservices().viewJanjianbyNidn(),
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
                        subtitle: Text("Tanggal : " + janjian[position].tgl + "\nJam : " + janjian[position].jam.toString() + "\nTersedia : " + janjian[position].isAvailable
                        ),
                        leading: Icon(Icons.calendar_today_sharp),
                        trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FormPengajuanJanjianMhs()),);
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
