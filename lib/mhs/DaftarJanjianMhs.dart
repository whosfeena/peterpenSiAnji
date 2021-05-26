import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/mhs/MhsUpdateJadwal.dart';

import '../apiservices.dart';
import '../model.dart';

class DaftarJanjianMhs extends StatefulWidget {
  final String title;
  DaftarJanjianMhs({Key key, this.title}) : super(key: key);

  @override
  _DaftarJanjianMhsState createState() => _DaftarJanjianMhsState();
}

class _DaftarJanjianMhsState extends State<DaftarJanjianMhs> {
  final _formKey = GlobalKey<FormState>();
  List<Janjian> janjian = new List();

  String get nim => null;

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Daftar Janjian Mahasiswa")),
      body: FutureBuilder(
        //future: apiservices().viewJanjianbyNim(janjian[position]).nim,
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
                        onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (_) => new AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      FlatButton(
                                        child: Text("Update"),
                                        onPressed: () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MhsUpdateJadwal()),);
                                        },
                                      ),
                                      Divider(
                                        color: Colors.black,
                                        height: 20,
                                      ),
                                      FlatButton(
                                          child: Text("Delete"),
                                          onPressed: () async{
                                            //apiservices().deleteMtk(lMtk[position].kode);
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
