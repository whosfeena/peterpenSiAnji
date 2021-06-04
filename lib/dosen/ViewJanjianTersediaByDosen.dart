import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../apiservices.dart';
import '../model.dart';
import 'DosenAddJadwalJanjian.dart';
import 'DosenUpdateJanjian.dart';

class ViewJanjianTersediaByDosen extends StatefulWidget {
  final String title;
  Janjian janjian;
  String nidn;

  ViewJanjianTersediaByDosen({Key key,  @required this.title, @required this.nidn}) : super(key: key);

  @override
  _ViewJanjianTersediaByDosenState createState() => _ViewJanjianTersediaByDosenState(title,nidn);
}

class _ViewJanjianTersediaByDosenState extends State<ViewJanjianTersediaByDosen> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  final String title;
  final String nidn;
  bool _isLoading = false;
  List<Janjian> janjian = new List();
  List<Dosen> dosen = new List();
  List<Mahasiswa> mhs = new List();

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
  _ViewJanjianTersediaByDosenState(this.title, this.nidn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DosenAddJadwalJanjian(title: "Tambah Jadwal Janjian")),
                ).then(onGoBack);
              },
            )
          ]
      ),
      body: FutureBuilder(
        future: apiservices().viewJanjianByDosenTersedia(nidn),
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

                        subtitle: Text("Tanggal : " + janjian[position].tgl.toString() +
                                "\nJam : " + janjian[position].jam.toString()
                        ),
                        leading: Icon(Icons.calendar_today_sharp),
                        trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (_) => new AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text("Perbarui Jadwal"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => DosenUpdateJanjian(title:"Form Pengajuan Janjian",
                                            janjian:janjian[position], kd_janjian:janjian[position].kd_janjian ,)),
                                        ).then(onGoBack);
                                      },
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      height: 20,
                                    ),
                                    FlatButton(
                                        child: Text("Hapus Janjian"),
                                        onPressed: () async{
                                          apiservices().deleteJanjian(janjian[position].kd_janjian);
                                          Navigator.pop(context);
                                          setState(() {});
                                        })
                                  ],
                                ),
                              )
                          );
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
