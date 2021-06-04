import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../apiservices.dart';
import '../model.dart';

class ListJanjianDitolak extends StatefulWidget {
  final String title;
  Mahasiswa mhs;
  String nim;
  String namaMhs;
  String username;
  Janjian janjian;
  String kd_janjian;

  ListJanjianDitolak({Key key, @required this.title, @required this.nim, @required this.username, @required this.kd_janjian}) : super(key: key);

  @override
  _ListJanjianDitolakState createState() => _ListJanjianDitolakState(title, nim, namaMhs, username, kd_janjian);
}

class _ListJanjianDitolakState extends State<ListJanjianDitolak> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  final String title;
  final String nim;
  final String namaMhs;
  final String username;
  final String kd_janjian;
  bool _isLoading = false;
  List<Mahasiswa> mhs = new List();
  List<Janjian> janjian = new List();

  _ListJanjianDitolakState(this.title, this.nim, this.namaMhs, this.username, this.kd_janjian);

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: apiservices().viewJanjianDitolak(nim),
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
                        subtitle: Text(
                            "NIDN Dosen       : " + janjian[position].nidn +
                                "\nTanggal              : " + janjian[position].tgl.toString() +
                                "\nJam                    : " + janjian[position].jam.toString() +
                                "\nTempat              : " + janjian[position].tempat +
                                "\nKeterangan       : " + janjian[position].ketJanjian +
                                "\nStatus Janjian  : " + janjian[position].sttsJanjian
                        ),
                        leading: Icon(Icons.calendar_today_sharp),
                        trailing: Icon(Icons.arrow_drop_down_circle_outlined),
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
