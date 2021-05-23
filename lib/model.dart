import 'dart:convert';
import 'package:flutter/material.dart';


//------------------------chart-----------------
/*class ClicksPerYear{
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year,this.clicks, Color color)
      : this.color = charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}*/

//----------------------dashboard-----------------------------
class DashboardSiAnji{
  String mahasiswa;
  String dosen;
  String janjian;

  DashboardSiAnji({this.mahasiswa, this.dosen, this.janjian});

  factory DashboardSiAnji.fromJson(Map<String, dynamic> json){
    return DashboardSiAnji(
        mahasiswa: json["mahasiswa"],
        dosen: json["dosen"],
        janjian: json["janjian"],
    );
  }
}

//-------------------------------daftar mahasiswa------------------
class Mahasiswa {
  String nim;
  String kode;
  String namaMhs;


  Mahasiswa({this.nim, this.kode, this.namaMhs});

  factory Mahasiswa.fromJson(Map<String, dynamic> map){
    return Mahasiswa(
        nim: map["nim"],
        kode: map["kode"],
        namaMhs: map["namaMhs"]
    );
  }

  Map<String, dynamic> toJson() {
    return {"nim": nim, "kode": kode, "namaMhs": namaMhs};
  }
}

List<Mahasiswa> mahasiswaFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<Mahasiswa>.from(data.map((item) => Mahasiswa.fromJson(item)));
}

String mahasiswaToJson(Mahasiswa data){
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

//-------------------------daftar dosen----------------------------
class Dosen{
  String nidn;
  String id;
  String namaDosen;

  Dosen({this.nidn, this.id, this.namaDosen,});


  factory Dosen.fromJson(Map<String, dynamic> map){
    return Dosen(
        nidn: map["nidn"],
        id: map["id"],
        namaDosen: map["namaDosen"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"nidn": nidn, "id": id, "namaDosen": namaDosen};
  }
}

List<Dosen>dosenFromJson(String jsonData){

  final data = json.decode(jsonData);
  return List<Dosen>.from(data.map((item) => Dosen.fromJson(item)));
}

String dosenToJson(Dosen data){
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

//-------------------------daftar janjian----------------------------
class Janjian{
  String kd_janjian;
  String nim;
  String nidn;
  int tgl;
  int jam;
  String tempat;
  String ketJanjian;
  String sttsJanjian;
  String isAvailable;

  Janjian({this.kd_janjian, this.nim, this.nidn, this.tgl, this.jam,
    this.tempat, this.ketJanjian, this.sttsJanjian, this.isAvailable});

  factory Janjian.fromJson(Map<String, dynamic> map){
    return Janjian(
        kd_janjian: map["kd_janjian"],
        nim: map["nim"],
        nidn: map["nidn"],
        tgl: int.parse(map["tgl"]),
        jam: int.parse(map["jam"]),
        tempat: map["tempat"],
        ketJanjian: map["ketJanjian"],
        sttsJanjian: map["sttsJanjian"],
        isAvailable: map["isAvailable"],
    );
  }
  Map<String, dynamic> toJson(){
    return{"kd_janjian":kd_janjian, "nim": nim, "nidn": nidn, "tgl": tgl, "jam": jam,
      "tempat": tempat, "ketJanjian": ketJanjian, "sttsJanjian": sttsJanjian, "isAvailable": isAvailable};
  }
}
List<Janjian> janjianFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<Janjian>.from(data.map((item) => Janjian.fromJson(item)));
}

String janjianToJson(Janjian data){
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

//---------------------------To Do---------------------------------
class ToDo{
  int userId;
  int id;
  String title;
  bool completed;
  ToDo({this.userId, this.id, this.title, this.completed});
}