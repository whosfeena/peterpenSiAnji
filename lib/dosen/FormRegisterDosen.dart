import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/mhs/DashboardMahasiswa.dart';

import 'DashboardDosen.dart';

class FormRegisterDosen extends StatefulWidget {
  const FormRegisterDosen({Key key}) : super(key: key);

  @override
  _FormRegisterDosenState createState() => _FormRegisterDosenState();
}

class _FormRegisterDosenState extends State<FormRegisterDosen> {

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return new Scaffold(
      appBar: new AppBar(title: Text("Registrasi Dosen")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10.0)
              ),
              Text('Selamat Datang di Aplikasi SiAnji!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15.0)
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "NIDN",
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5),
                  )
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(7.0)
              ),
              new TextFormField(
                decoration: new InputDecoration(
                    labelText: "Nama Lengkap",
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5),
                    )
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15.0)
              ),
              MaterialButton(
                minWidth: 400,
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardDosen()),);
                },
                child: Text('Simpan', textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}


