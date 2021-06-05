import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peterpan_app2/model.dart';

import '../apiservices.dart';

class DosenAddJadwalJanjian extends StatefulWidget {
  String title;
  String nidn;
  Janjian janjian;
  Dosen dosen;
  DosenAddJadwalJanjian({Key key, this.title, this.janjian, this.dosen, this.nidn}) : super(key: key);

  @override
  _DosenAddJadwalJanjianState createState() => _DosenAddJadwalJanjianState(title,janjian,dosen,nidn);
}

class _DosenAddJadwalJanjianState extends State<DosenAddJadwalJanjian> {
  String title;
  final String nidn;
  Janjian janjian;
  Dosen dosen;
  List<Janjian> janji = new List();
  Janjian model = new Janjian();
  final _formKey = GlobalKey<FormState>();


  final DateFormat dateFormat = DateFormat.yMMMMd();

  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();


  //untuk calendar
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  TextEditingController intialdateval = TextEditingController();

  _DosenAddJadwalJanjianState(this.title, this.janjian, this.dosen, this.nidn);



  //class date
  Future<Null> selectDate(BuildContext context) async{
    final DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
      //selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
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
      appBar:AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Column(
              children: <Widget>[

                SizedBox(height: 15,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    enabled: false,
                    prefixIcon: Icon(
                        Icons.format_list_numbered),
                    labelText: "NIDN Dosen",
                    hintText: "Masukkan NIDN",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(
                        20.0, 15.0, 20.0, 15.0),
                  ),
                  initialValue: nidn,
                  onSaved: (String value) {
                    this.model.nidn = value;
                  },
                ),

                SizedBox(height: 15,
                ),
                TextFormField(
                  //readOnly: false,
                  onTap: () async {
                    setState(() {
                      selectDate(context).toString();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                    hintText: (dateFormat.format(_date)).toString(),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
                    contentPadding: EdgeInsets.fromLTRB(
                        20.0, 15.0, 20.0, 15.0),
                  ),
                  //initialValue: this.janjian.tgl.toString(),
                  onSaved: (String value) {
                    this.model.tgl = _date.toString();
                  },
                ),

                SizedBox(height: 15,
                ),
                TextFormField(
                  //readOnly: true,

                  //initialValue: this.janjian.jam.toString(),
                  onTap: () async {
                    setState(() {
                      selectedTime(context).toString();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.access_time_outlined),
                    hintText: (_time.format(context)).toString(),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
                    contentPadding: EdgeInsets.fromLTRB(
                        20.0, 15.0, 20.0, 15.0),
                  ),
                  onSaved: (String value) {
                    this.model.jam = _time.format(context).toString();
                  },
                ),

                Padding(padding: EdgeInsets.all(10.0)
                ),

                MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    color: Colors.blue,
                    child : Text("Simpan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: () async {
                      _formKey.currentState.save();
                      model.isAvailable = "TRUE";
                      model.sttsJanjian= "MENUNGGU";
                      apiservices().dosenCreateJanjian(this.model);
                      Navigator.pop(context);
                    }
                ),
              ]
          ),
        ),

      ),
    );
  }
}
