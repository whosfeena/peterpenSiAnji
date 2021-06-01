import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../apiservices.dart';
import '../model.dart';

class DosenVerifikasi extends StatefulWidget {
  final String title;
  Janjian janjian;
  String kd_janjian;
  String nidn;
  DosenVerifikasi({Key key,@required this.title, @required this.nidn, @required this.kd_janjian}) : super(key: key);

  @override
  _DosenVerifikasiState createState() => _DosenVerifikasiState(title, kd_janjian, nidn);
}

class _DosenVerifikasiState extends State<DosenVerifikasi> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  final String title;
  final String kd_janjian;
  final String nidn;
  bool _isLoading = false;
  List<Janjian> janjian = new List();
  List<Dosen> dosen = new List();
  List<Mahasiswa> mhs = new List();

  _DosenVerifikasiState(this.title, this.kd_janjian, this.nidn);

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Jadwal Janjian Dosen")),
      body: FutureBuilder(
        future: apiservices().ViewJanjianMenuggu(nidn),
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
                                        child: Text("Terima Janjian"),
                                        onPressed: () {
                                          //_formKey.currentState.save();
                                          apiservices().verifikasiJanjianTerima(janjian[position].kd_janjian);
                                          Navigator.pop(context);
                                        }
                                      ),
                                      OutlineButton(
                                          child: Text("Tolak Janjian"),
                                          onPressed: () {
                                            //_formKey.currentState.save();
                                            apiservices().verifikasiJanjianTolak(janjian[position].kd_janjian);
                                            Navigator.pop(context);
                                          }
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
