import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/home_screen.dart';

class pengajuanjanjian extends StatefulWidget {
  const pengajuanjanjian({Key key}) : super(key: key);

  @override
  _pengajuanjanjianState createState() => _pengajuanjanjianState();
}

class _pengajuanjanjianState extends State<pengajuanjanjian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pengajuan Janjian")),
      body: Container(
          height: 500,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
          ),
          padding : const EdgeInsets.all(3.0),
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Center (
            child: Column(
              children: [
                Text("Pengajuan Janjian"),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text('Selamat Pengajuanmu Diterima'),
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      ),
                      Container(
                        child: Text('Maaf Pengajuanmu Ditolak'),
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      ),
                      Container(
                        child: Text('Jangan Lupa kamu punya janji dengan Dosen A'),
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      )
                    ],
                  ),
                  height: 400,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey)
                  ),
                  padding : const EdgeInsets.all(3.0),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                )
              ],
            ),
          )
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Nama'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('NIM'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Email'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('LOGOUT'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
