import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class listjanjian extends StatefulWidget {
  const listjanjian({Key key}) : super(key: key);

  @override
  _listjanjianState createState() => _listjanjianState();
}

class _listjanjianState extends State<listjanjian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: new Icon(Icons.list),
        title: new Text('List Janjian Tersedia'),
        backgroundColor: Colors.teal,
      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(
                hintText: "Pilih Dosen",
                labelText: "Pilih Dosen",
                border: new OutlineInputBorder()
              ),
            )
          ],
        ),
      ),
    );
  }
}
