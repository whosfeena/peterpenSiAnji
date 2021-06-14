import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peterpan_app2/apiservices.dart';
import 'package:peterpan_app2/mhs/ListJanjianMahasiswa.dart';
import 'package:peterpan_app2/model.dart';

class FormMhsBuatJadwal extends StatefulWidget {
  final String title;
  String nim;
  Janjian janjian;
  Dosen dosen;
  Mahasiswa mhs;
  FormMhsBuatJadwal({Key key, this.title,this.nim}) : super(key: key);


  @override
  _FormMhsBuatJadwalState createState() => _FormMhsBuatJadwalState(title,nim);
}

class _FormMhsBuatJadwalState extends State<FormMhsBuatJadwal> {
  String title;
  String nim;
  Janjian janjian;
  Dosen dosen;
  Mahasiswa mhs;
  List<Janjian> janji = new List();
  bool tabrakan = false;
  Janjian model = new Janjian();
  final _formKey = GlobalKey<FormState>();


  final DateFormat dateFormat = DateFormat.yMMMMd();

  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();

  //untuk calendar
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  TextEditingController intialdateval = TextEditingController();

  _FormMhsBuatJadwalState(this.title,this.nim);


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
      appBar: AppBar(
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
          } else if (snapshot.connectionState == ConnectionState.done)
          {
           janji = snapshot.data;
      //     mhs.nim = nim;
           return SingleChildScrollView(
             child: Form(
               key: _formKey,
               //mhs.nim = "72180188";
               child: SingleChildScrollView(
                 padding: EdgeInsets.all(15.0),
                 child: Column(
                     children: <Widget>[
                       Text('Anda Akan Mengajukan Jadwal Janjian Diluar Jadwal yang Dimiliki Dosen',
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

                       SizedBox(height: 15,
                       ),
                       TextFormField(
                         decoration: InputDecoration(
                           prefixIcon: Icon(
                               Icons.format_list_numbered),
                           enabled: true,
                           labelText: "NIDN",
                           hintText: "Masukkan NIDN",
                           border: OutlineInputBorder(),
                           contentPadding: EdgeInsets.fromLTRB(
                               20.0, 15.0, 20.0, 15.0),
                         ),
                         //initialValue: nim,
                         onSaved: (String value) {
                           this.model.nidn = value.toString();
                         },
                       ),

                       SizedBox(height: 15,
                       ),
                       TextFormField(
                         decoration: InputDecoration(
                           prefixIcon: Icon(
                               Icons.format_list_numbered),
                           enabled: false,
                           labelText: "NIM",
                           hintText: "Masukkan NIM",
                           border: OutlineInputBorder(),
                           contentPadding: EdgeInsets.fromLTRB(
                               20.0, 15.0, 20.0, 15.0),
                         ),
                         initialValue: nim,
                         onSaved: (String value) {
                           this.model.nim = value;
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
                         //initialValue: this.janjian.tempat,
                         onSaved: (String value) {
                           this.model.tempat = value;
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
                         //initialValue: this.janjian.ketJanjian,
                         onSaved: (String value) {
                           this.model.ketJanjian = value;

                         },

                       ),

                       Padding(
                           padding: EdgeInsets.all(15.0)
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
                             model.isAvailable = "FALSE";
                             model.sttsJanjian = "MENUNGGU";
                             model.createdBy = nim;

                             apiservices().mhsCreateJanjian(this.model);
                             Navigator.pop(context);
                             }








                       ),


                     ]
                 ),
               ),
             ),
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
