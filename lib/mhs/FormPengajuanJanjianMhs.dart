import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peterpan_app2/model.dart';

import '../apiservices.dart';


class FormPengajuanJanjianMhs extends StatefulWidget {

  final String title;
  Janjian janjian;
  Dosen dosen;
  String nidn;
  String nim;
  String kd_janjian;

  FormPengajuanJanjianMhs({Key key,
    @required this.title,
    @required this.janjian,
    @required this.dosen,
    @required this.nidn,
    @required this.nim,
    @required this.kd_janjian
  }) : super(key: key);


  @override
  _FormPengajuanJanjianMhsState createState() => _FormPengajuanJanjianMhsState(
      title,
      janjian,
      dosen,
      nidn,
      nim,
      kd_janjian
  );
}

class _FormPengajuanJanjianMhsState extends State<FormPengajuanJanjianMhs> {
  final _formKey = GlobalKey<FormState>();
  final String title;
  final String nidn;
  final String nim;
  final String kd_janjian;
  bool _isLoading = false;
  Janjian janjian;
  List<Janjian> janji = new List();
  List<Dosen> dsn = new List();
  Dosen dosen;
  DateTime _selectDate;


  _FormPengajuanJanjianMhsState(
      this.title,
      this.janjian,
      this.dosen,
      this.nidn,
      this.nim,
      this.kd_janjian
      );



  final DateFormat dateFormat = DateFormat.yMMMMd();

  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();

  //untuk calendar
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  TextEditingController intialdateval = TextEditingController();


  //class date
  Future<Null> selectDate(BuildContext context) async{
    final DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
    );

    if (_datePicker != null && _datePicker != _date){
      setState(() {
        _date = _datePicker;
        print(_date.toString());
      });
    }
  }

  Future<Null> selectedTime(BuildContext context) async {
    final TimeOfDay _timePicker = await showTimePicker(
        context: context,
        initialTime: _time,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });

    if (_timePicker != null && _timePicker != _time)
      setState(() {
        _time = _timePicker;
        print(_time.toString());
      });
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Form Pengajuan Janjian"),
      ),
      body:SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15.0),
            child: Column(
                children: <Widget>[
                  Text(
                    'Anda Akan Mengajukan Jadwal Janjian Sesuai Jadwal yang Dimiliki Dosen',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5.0)
                  ),

                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                          Icons.format_list_numbered),
                      enabled: true,
                      labelText: "NIM",
                      hintText: "Masukkan NIM",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 15.0, 20.0, 15.0),
                    ),
                    initialValue: this.janjian.nim,
                    onSaved: (String value) {
                      this.janjian.nim = value;
                      },
                  ),


                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.place),
                      enabled: true,
                      labelText: "Tempat",
                      hintText: "Masukkan Tempat",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 15.0, 20.0, 15.0),
                    ),
                    initialValue: this.janjian.tempat,
                    onSaved: (String value) {
                      this.janjian.tempat = value;
                      },
                  ),

                  SizedBox(height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.pending_rounded),
                      enabled: true,
                      labelText: "Keterangan Janjian",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 15.0, 20.0, 15.0),
                    ),
                    initialValue: this.janjian.ketJanjian,
                    onSaved: (String value) {
                      this.janjian.ketJanjian = value;
                      },
                  ),

                  Padding(
                      padding: EdgeInsets.all(15.0)
                  ),

                  MaterialButton(
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: EdgeInsets.fromLTRB(
                        20.0, 15.0, 20.0, 15.0),
                    color: Colors.blue,
                    onPressed: () {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Ajukan Janjian"),
                            content: Text(
                                " Apakah anda akan menyimpan data ini?"),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () async {
                                  _formKey.currentState.save();
                                  setState(() => _isLoading = true);
                                  apiservices().mhsAjukanJdwlJanji(this.janjian, kd_janjian).then((isSuccess){
                                    setState(() => _isLoading = false);
                                    if (isSuccess){
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    } else{
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  });
                                  },
                                child: Text("Ya"),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  },
                                child: Text("Tidak"),
                              )
                            ],
                          );
                          },
                      );
                      },
                    child: Text(
                      'Simpan', textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                  ),

                ]
            ),
          ),
        ),
      ),
    );
  }
  }
