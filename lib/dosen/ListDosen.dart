import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/apiservices.dart';
import 'package:peterpan_app2/dosen/DashboardDosen.dart';
import 'package:peterpan_app2/mhs/FormPengajuanJanjianMhs.dart';
import 'package:peterpan_app2/model.dart';
import 'ListJadwalJanjianDosen.dart';

class ListDosen extends StatefulWidget {

  final String title;
  String kd_janjian;

  ListDosen({Key key, @required this.title, @required this.kd_janjian}) : super(key: key);
  @override
  _ListDosenState createState() => _ListDosenState(title, kd_janjian);
}

class _ListDosenState extends State<ListDosen> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  final String title;
  final String kd_janjian;
  bool _isLoading = false;
  List<Dosen> dsn = new List();
  List<Janjian> janjian = new List();

  _ListDosenState(this.title, this.kd_janjian);

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Daftar Dosen")),
      body: FutureBuilder(
        future: apiservices().getDosen(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Dosen>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done)
          {
            dsn = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, position) {
                return Card(
                    margin: new EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 1.0),
                    child: Container(
                      child: ListTile(
                        title: Text(
                            dsn[position].namaDosen,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize:14,
                                fontWeight: FontWeight.bold)
                            ),
                        subtitle: Text("NIDN :" + dsn[position].nidn,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize:11,
                                color: Colors.teal
                            )),
                        leading: Icon(Icons.person),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ListJadwalJanjianDosen()),);
                          Navigator.pop(context);
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListJadwalJanjianDosen(title: "Jadwal Janjian Dosen",
                               nidn:dsn[position].nidn)),
                          ).then(onGoBack);
                          },
                      ),
                      ),
                    );
              },
              itemCount: dsn.length,
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