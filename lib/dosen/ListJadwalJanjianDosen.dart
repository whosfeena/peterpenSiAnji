import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListJadwalJanjianDosen extends StatefulWidget {
  const ListJadwalJanjianDosen({Key key}) : super(key: key);

  @override
  _ListJadwalJanjianDosenState createState() => _ListJadwalJanjianDosenState();
}

class _ListJadwalJanjianDosenState extends State<ListJadwalJanjianDosen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Jadwal Janjian Dosen")),
    );
  }
}
