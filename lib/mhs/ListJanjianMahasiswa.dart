import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/mhs/FormMhsBuatJadwal.dart';

import '../apiservices.dart';
import '../model.dart';
import 'FormPengajuanJanjianMhs.dart';

class ListJanjianMahasiswa extends StatefulWidget {
  final String title;
  Mahasiswa mhs;
  String nim;
  String namaMhs;
  String username;
  Janjian janjian;
  String kd_janjian;
  ListJanjianMahasiswa({Key key, @required this.title, @required this.nim, @required this.username, @required this.kd_janjian}) : super(key: key);

  @override
  _ListJanjianMahasiswaState createState() => _ListJanjianMahasiswaState(title, nim, namaMhs, username, kd_janjian);
}

class _ListJanjianMahasiswaState extends State<ListJanjianMahasiswa> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  final String title;
  final String nim;
  final String namaMhs;
  final String username;
  final String kd_janjian;
  bool _isLoading = false;
  List<Mahasiswa> mhs = new List();
  List<Janjian> janjian = new List();

  _ListJanjianMahasiswaState(this.title, this.nim, this.namaMhs, this.username, this.kd_janjian);

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: apiservices().viewJanjianbyNim(nim),
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
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => new AlertDialog(
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      OutlineButton(
                                        child: Text("Hapus Janjiannn"),
                                        onPressed: () async{
                                          Navigator.pop(context);
                                          janjian[position].isAvailable = "FALSE";
                                          apiservices().deleteJanjian(janjian[position].kd_janjian);
                                          setState(() {});
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
