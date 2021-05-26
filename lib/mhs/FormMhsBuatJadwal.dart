import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormMhsBuatJadwal extends StatefulWidget {
  final String title;
  FormMhsBuatJadwal({Key key, this.title}) : super(key: key);


  @override
  _FormMhsBuatJadwalState createState() => _FormMhsBuatJadwalState();
}

class _FormMhsBuatJadwalState extends State<FormMhsBuatJadwal> {
  final _formKey = GlobalKey<FormState>();
  final df = new DateFormat('dd-MM-yyyy hh:mm a');

  TextEditingController dateCtl = TextEditingController();
  TextEditingController timeCtl = TextEditingController();

  //untuk calendar
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  //class date
  Future<Null> selectTimePicker(BuildContext context) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7? false : true,
    );
    if (picked!= null && picked != date){
      setState(() {
        date = picked;
        print(date.toString());
      });
    }
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String _formattedate = new DateFormat.yMMMMEEEEd().format(date);
    return new Scaffold(
      appBar: new AppBar(title: Text("Pengajuan Janjian"),),
      body: Form(
        key: _formKey,
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
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.format_list_numbered),
                    enabled: true,
                    labelText: "NIM",
                    hintText: "Masukkan NIM",
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
                    prefixIcon: Icon(Icons.format_list_numbered),
                    enabled: true,
                    labelText: "NIDN Dosen",
                    hintText: "",
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
                  controller: dateCtl,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                    enabled: true,
                    labelText: "Tanggal Janjian",
                    hintText: (date.toString()),
                    filled: true,//,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                  onTap: ()async{
                    FocusScope.of(context).requestFocus(new FocusNode());
                    DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2040),
                      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7? false : true,
                    );
                    dateCtl.text = _formattedate.toString();
                    if(picked != null && picked != date){
                      setState(() {
                        date = picked;
                      });
                    }
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return "Can't be empty";
                    }
                    return null;
                  },
                  /*initialValue: this.janjian.tgl,
                    onSaved: (String value){
                      this.janjian.tgl=value;
                    },*/
                ),

                SizedBox(height: 15,
                ),
                TextFormField(
                  controller: timeCtl,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.access_time),
                    enabled: true,
                    labelText: "Waktu",
                    hintText: "Masukkan Waktu",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                  onTap: () async{
                    TimeOfDay time = TimeOfDay.now();
                    FocusScope.of(context).requestFocus(new FocusNode());

                    TimeOfDay picked = await showTimePicker(context: context, initialTime: time);
                      if (picked != null && picked != time)
                        timeCtl.text = picked.toString();
                        setState(() {
                          time = picked;
                        });
                    },
                    validator: (value) {
                    if (value.isEmpty) {
                      return 'cant be empty';
                    }
                    return null;
                  },
                  /*initialValue: this.janjian.jam,
                    onSaved: (String value){
                      this.janjian.jam=value;
                    },*/
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
                    prefixIcon: Icon(Icons.pending_rounded),
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

                Padding(
                    padding: EdgeInsets.all(15.0)
                ),

                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  color: Colors.blue,
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
                                _formKey.currentState.save();
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
                  child: Text('Simpan', textAlign: TextAlign.center,
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
    );
  }
}
