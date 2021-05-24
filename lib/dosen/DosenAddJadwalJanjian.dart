import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/model.dart';

class DosenAddJadwalJanjian extends StatefulWidget {
  DosenAddJadwalJanjian({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DosenAddJadwalJanjianState createState() => _DosenAddJadwalJanjianState(title);
}

class _DosenAddJadwalJanjianState extends State<DosenAddJadwalJanjian> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final String title;
  _DosenAddJadwalJanjianState(this.title);
  Dosen dsn =new Dosen();

  TextEditingController _controller = new TextEditingController();
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.title),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SingleChildScrollView(
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
                        hintText: ""
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )

      ),
    );
  }
}
