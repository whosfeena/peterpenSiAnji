import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/model.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey <ScaffoldState>();

class FormPengajuanJanjianMhs extends StatefulWidget {

  final String title;
  /*Janjian janjian;
  String kd_janjian;*/

  FormPengajuanJanjianMhs({Key key,this.title}) : super(key: key);


  @override
  _FormPengajuanJanjianMhsState createState() => _FormPengajuanJanjianMhsState();
}

class _FormPengajuanJanjianMhsState extends State<FormPengajuanJanjianMhs> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  /*final String kd_janjian;
  Janjian janjian;*/

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Jadwal Janjian Dosen"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Stack(
          children: <Widget>[
            Form(
              key: _formState,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: "Kode Janjian",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    /*initialValue: this.janjian.kd_janjian,
                      onSaved: (String value){
                      this.janjian.kd_janjian=value;
                      },*/
                  ),

                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      enabled: true,
                      labelText: "NIM",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    /*initialValue: this.janjian.nim,
                    onSaved: (String value){
                      this.janjian.nim=value;
                    },*/
                  ),

                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: "NIDN Dosen",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    /*initialValue: this.janjian.nidn,
                    onSaved: (String value){
                      this.janjian.nidn=value;
                    },*/
                  ),

                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: "Tanggal Janjian",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    /*initialValue: this.janjian.tgl,
                    onSaved: (String value){
                      this.janjian.tgl=value;
                    },*/
                  ),

                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: "Jam",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    /*initialValue: this.janjian.jam,
                    onSaved: (String value){
                      this.janjian.jam=value;
                    },*/
                  ),

                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      enabled: true,
                      labelText: "Tempat",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    /*initialValue: this.janjian.tempat,
                    onSaved: (String value){
                      this.janjian.tempat=value;
                    },*/
                  ),

                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      enabled: true,
                      labelText: "Keterangan Janjian",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    /*initialValue: this.janjian.ketJanjian,
                    onSaved: (String value){
                      this.janjian.ketJanjian=value;
                    },*/
                  ),

                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      enabled: true,
                      labelText: "Keterangan Janjian",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                    /*initialValue: this.janjian.ketJanjian,
                    onSaved: (String value){
                      this.janjian.ketJanjian=value;
                    },*/
                  ),


              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                color: Colors.brown,
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Simpan Data"),
                        content: Text(" Apakah anda akan menyimpan data ini?"),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () async{
                              _formState.currentState.save();
                              /*this.mtk.nim_progmob = "72180188";
                              setState(() => _isLoading = true);
                              ApiServices().createMtk(this.mtk).then((isSuccess){
                                setState(() => _isLoading = false);
                                if (isSuccess){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else{
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              });*/
                            },
                            child: Text("Ya"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text ("Tidak"),
                          )
                        ],
                      );
                    },
                  );
                },
              ),







                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
