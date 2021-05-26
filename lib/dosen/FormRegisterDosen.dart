import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/apiservices.dart';
import 'package:peterpan_app2/mhs/DashboardMahasiswa.dart';
import 'package:peterpan_app2/model.dart';

import 'DashboardDosen.dart';

class FormRegisterDosen extends StatefulWidget {
  String title;
  String nim;
  String namaDosen;
  String username;
  FormRegisterDosen({Key key, @required this.title, @required this.nim, @required this.namaDosen, @required this.username}) : super(key: key);

  @override
  _FormRegisterDosenState createState() => _FormRegisterDosenState(title,nim,namaDosen,username);
}

class _FormRegisterDosenState extends State<FormRegisterDosen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final String title;
  bool _isLoading = false;
  Dosen dosen = new Dosen();
  UserGoogle Google = new UserGoogle();
  List<Dosen> dsn = new List();


  String nim;
  String namaMhs;
  String username;

  _FormRegisterDosenState(this.title, this.nim, this.namaMhs, this.username);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("Registrasi Dosen")),
      body: Form(
        key: _formState,
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
                  onSaved: (String value){
                    this.dosen.nidn = value;
                  }
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
                  onSaved: (String value) {
                    this.dosen.namaDosen = value;
                  }
              ),
              Padding(
                  padding: EdgeInsets.all(7.0)
              ),
              new TextFormField(
                  decoration: new InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5),
                      )
                  ),
                  onSaved: (String value) {
                    this.dosen.username = value;
                    this.Google.username = value;
                    this.Google.role = "0";
                  }
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
                    _formState.currentState.save();
                    apiservices().createDosen(this.dosen);
                    apiservices().createSession(this.Google);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => DashboardDosen(title: "Dashboard Dosen",)));
                  }

              ),

              _isLoading
                  ? Stack(
                children: <Widget>[
                  Opacity(
                    opacity: 0.3,

                    child: ModalBarrier(
                      dismissible: false,
                      color: Colors.grey,
                    ),
                  ),
                  Center(
                    child:  CircularProgressIndicator(),
                  )
                ],
              )
                  : Container(),

            ],
          ),
        ),
      ),
    );
  }
}


