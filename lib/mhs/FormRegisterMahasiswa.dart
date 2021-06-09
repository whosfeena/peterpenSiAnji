import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peterpan_app2/apiservices.dart';

import '../model.dart';
import 'DashboardMahasiswa.dart';

class FormRegisterMahasiswa extends StatefulWidget {
  String title;
  String nim;
  String namaMhs;
  String username;
  FormRegisterMahasiswa({Key key, @required this.title, @required this.nim, @required this.namaMhs, @required this.username}) : super(key: key);

  @override
  _FormRegisterMahasiswaState createState() => _FormRegisterMahasiswaState(title,nim,namaMhs,username);
}

class _FormRegisterMahasiswaState extends State<FormRegisterMahasiswa> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final String title;
  bool _isLoading = false;
  Mahasiswa mahasiswa = new Mahasiswa();
  UserGoogle Google = new UserGoogle();
  List<Mahasiswa> mhs = new List();

  final myNimController = TextEditingController();
  final myUsernameController = TextEditingController();
  final myNamaController = TextEditingController();


  String nim;
  String namaMhs;
  String username;

  _FormRegisterMahasiswaState(this.title, this.nim, this.namaMhs, this.username);



  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(title: Text("Registrasi Mahasiswa")),
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
                  validator: (value){
                    if(value.isEmpty && value.length == 0) {
                      return "NIM tidak boleh kosong";
                    } else
                      return null;
                  },
                  controller: myNimController,
                  decoration: new InputDecoration(
                    labelText: "NIM",
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5),
                    )
                ),
                onSaved: (String value){
                  this.mahasiswa.nim = value;
                }
              ),
              Padding(
                  padding: EdgeInsets.all(7.0)
              ),
              new TextFormField(
                  validator: (value){
                    if(value.isEmpty && value.length == 0) {
                      return "Nama tidak boleh kosong";
                    } else
                      return null;
                  },
                  controller: myNamaController,
                  decoration: new InputDecoration(
                    labelText: "Nama Lengkap",
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5),
                    )
                ),
                onSaved: (String value) {
                  this.mahasiswa.namaMhs = value;
                }
              ),
              Padding(
                  padding: EdgeInsets.all(15.0)
              ),
              new TextFormField(
                  decoration: new InputDecoration(
                    enabled: false,
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5),
                    )
                ),
                  initialValue: username,
                  onSaved: (String value) {
                    this.mahasiswa.username = value;
                    this.Google.username = value;
                    this.Google.role = "1";
                    this.Google.id = mahasiswa.nim;

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
                  if(_formState.currentState.validate()){
                    _formState.currentState.save();
                    apiservices().createMhs(this.mahasiswa);
                    apiservices().createSession(this.Google);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => DashboardMahasiswa(title: "Dashboard Mahasiswa",nim : mahasiswa.nim, namaMhs: mahasiswa.namaMhs, username: mahasiswa.username, email: mahasiswa.username,)));
                  }
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
