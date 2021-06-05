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
  String namaMhs;
  String username;


  Mahasiswa({this.nim,this.namaMhs,this.username});

  factory Mahasiswa.fromJson(Map<String, dynamic> map){
    return Mahasiswa(
        nim: map["nim"],
        namaMhs: map["namaMhs"],
        username: map["username"]
    );
  }

  Map<String, dynamic> toJson() {
    return {"nim": nim,"namaMhs": namaMhs,"username" : username};
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
  String namaDosen;
  String username;

  Dosen({this.nidn,this.namaDosen, this.username});


  factory Dosen.fromJson(Map<String, dynamic> map){
    return Dosen(
        nidn: map["nidn"],
        namaDosen: map["namaDosen"],
        username: map["username"]
    );
  }

  Map<String, dynamic> toJson() {
    return {"nidn": nidn, "namaDosen": namaDosen, "username": username};
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
  String tgl;
  String jam;
  String tempat;
  String ketJanjian;
  String sttsJanjian;
  String isAvailable;
  String createdBy;

  Janjian({this.kd_janjian, this.nim, this.nidn, this.tgl, this.jam,
    this.tempat, this.ketJanjian, this.sttsJanjian, this.isAvailable, this.createdBy});

  factory Janjian.fromJson(Map<String, dynamic> map){
    return Janjian(
        kd_janjian: map["kd_janjian"],
        nim: map["nim"],
        nidn: map["nidn"],
        tgl: map["tgl"],
        jam: map["jam"],
        tempat: map["tempat"],
        ketJanjian: map["ketJanjian"],
        sttsJanjian: map["sttsJanjian"],
        isAvailable: map["isAvailable"],
        createdBy: map["createdBy"]
    );
  }
  Map<String, dynamic> toJson(){
    return{"kd_janjian":kd_janjian, "nim": nim, "nidn": nidn, "tgl": tgl, "jam": jam,
      "tempat": tempat, "ketJanjian": ketJanjian, "sttsJanjian": sttsJanjian, "isAvailable": isAvailable, "createdBy":createdBy};
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

//-------------------------------daftar userGoogle------------------
class UserGoogle {
  String username;
  String role;
  String id;
  UserGoogle ({this.username,this.role,this.id});

  factory UserGoogle.fromJson(Map<String, dynamic> map){
    return UserGoogle(
        username: map["username"],
        role: map["role"],
        id: map["id"]
    );
  }

  Map<String, dynamic> toJson() {
    return {"username" : username,"role" : role, "id" : id};
  }
}

List<UserGoogle> UserGoogleFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<UserGoogle>.from(data.map((item) => UserGoogle.fromJson(item)));
}

String UserGoogleToJson(UserGoogle data){
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