import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../apiservices.dart';
import '../model.dart';
import 'DosenAddJadwalJanjian.dart';

class ViewJanjianReqByMhs extends StatefulWidget {
  final String title;
  Janjian janjian;
  String nidn;
  ViewJanjianReqByMhs({Key key, @required this.title, @required this.nidn}) : super(key: key);

  @override
  _ViewJanjianReqByMhsState createState() => _ViewJanjianReqByMhsState(title,nidn);
}

class _ViewJanjianReqByMhsState extends State<ViewJanjianReqByMhs> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  final String title;
  final String nidn;
  bool _isLoading = false;
  List<Janjian> janjian = new List();
  List<Dosen> dosen = new List();
  List<Mahasiswa> mhs = new List();

  _ViewJanjianReqByMhsState(this.title, this.nidn);

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

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
        future: apiservices().viewJanjianCreatedbyNim(nidn),
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
                            "NIM : " + janjian[position].nim.toString()+
                                "\nTanggal : " + janjian[position].tgl.toString() +
                                "\nJam : " + janjian[position].jam.toString() +
                                "\nTempat : " + janjian[position].tempat.toString() +
                                "\nKeterangan : " + janjian[position].ketJanjian.toString() +
                                "\nStatus Janjian : " + janjian[position].sttsJanjian.toString()
                        ),
                        leading: Icon(Icons.calendar_today_sharp),
                        trailing: Icon(Icons.arrow_drop_down_circle_outlined),
                        /*onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => new AlertDialog(
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      OutlineButton(
                                          child: Text("Hapus Janjian"),
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
                        },*/
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
