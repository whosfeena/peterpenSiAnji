import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:peterpan_app2/model.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class apiservices {
  final String baseUrl = "http://192.168.1.7/peterpensianji/aplikasi-slim/public";

  Client client = Client();


  // ----------- Mahasiswa ----------- //
  Future<bool> createMhs(Mahasiswa data) async{
    final response = await client.post("$baseUrl/Mhs/Register/",
        headers: {"content-type": "application/json"},
        body: mahasiswaToJson(data)
    );
    if(response.statusCode ==200){
      return true;
    }else{
      return false;
    }
  }


  // ----------- Dosen ----------- //

  //Menampilkan semua dosen
  Future<List<Dosen>> getDosen() async{
    final response = await client.get("$baseUrl/DosenGetAll/");
    if (response.body.isNotEmpty){
      return dosenFromJson(response.body);
    }else{
      return null;
    }
  }

  //Menampilkan nama dosen berdasarkan nidn
  Future<List<Dosen>> getOneDosen(String nidn) async{
    final response = await client.get("$baseUrl/DosenGetByID/"+nidn);
    if (response.statusCode == 200){
      return dosenFromJson(response.body);
    }else{
      return null;
    }
  }

  //Create Data Dosen Dosen
  Future<bool> createDosen(Dosen data) async{
    var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/Dosen/Register/")
    );

    Map<String,String> headers={
      "Content-type":"multipart/form-data"
    };

    request.headers.addAll(headers);
    request.fields.addAll({
      "nidn":data.nidn,
      "id":data.id.toString(),
      "namaDosen":data.namaDosen
    });

    var response = await request.send();
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  /*//Create jadwal janjian by Dosen
  Future<bool> createJadwal(String kode, int tgl, int jam) async {
    int idDosen, idMatkul;
    List<Janjian> janjian = await getOneMatakuliah(kode);
    developer.log("janjian : "+janjian.toString());
    if(janjian == null || janjian.length == 0) {
      return false;
    } else {
      idMatkul = int.parse(janjian[0].id);
    }
    List<Dosen> dosen = await getOneDosen(nidn);
    developer.log("dosen : "+dosen.toString());
    if(dosen == null || dosen.length == 0) {
      return false;
    } else {
      idDosen = int.parse(dosen[0].id);
    }
    developer.log("id matkul : "+idMatkul.toString());
    developer.log("id dosen : "+idDosen.toString());
    final response = await client.post("$baseUrl/Dosen/CreateJanjian/",
        headers: {"content-type": "application/json"},
        body: json.encode({
          "id_dosen": idDosen,
          "id_matkul": idMatkul,
          "nim_progmob": nimProgmob
        })
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }



  // ----------- Jadwal
  Future<List<Jadwal>> getJadwal() async{
    final response = await client.get("$baseUrl/api/progmob/jadwal/72180188");
    if (response.statusCode == 200){
      return jadwalFromJson(response.body);
    }else{
      return null;
    }
  }
  Future<bool> createJadwal(String kode, String nidn, String nimProgmob) async {
    int idDosen, idMatkul;
    List<MataKuliah> matkul = await getOneMatakuliah(kode);
    developer.log("matkul : "+matkul.toString());
    if(matkul == null || matkul.length == 0) {
      return false;
    } else {
      idMatkul = int.parse(matkul[0].id);
    }
    List<Dosen> dosen = await getOneDosen(nidn);
    developer.log("dosen : "+dosen.toString());
    if(dosen == null || dosen.length == 0) {
      return false;
    } else {
      idDosen = int.parse(dosen[0].id);
    }
    developer.log("id matkul : "+idMatkul.toString());
    developer.log("id dosen : "+idDosen.toString());
    final response = await client.post("$baseUrl/api/progmob/jadwal/create",
        headers: {"content-type": "application/json"},
        body: json.encode({
          "id_dosen": idDosen,
          "id_matkul": idMatkul,
          "nim_progmob": nimProgmob
        })
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  Future<bool> updateJdwl(Jadwal data, String kodeMatkul, String idCari) async {
    int idDosen, idMatkul;
    List<MataKuliah> matkul = await getOneMatakuliah(kodeMatkul);
    developer.log("matkul : "+matkul.toString());
    if(matkul == null || matkul.length == 0) {
      return false;
    } else {
      idMatkul = int.parse(matkul[0].id);
    }
    List<Dosen> dosen = await getOneDosen(data.nidn);
    developer.log("dosen : "+dosen.toString());
    if(dosen == null || dosen.length == 0) {
      return false;
    } else {
      idDosen = int.parse(dosen[0].id);
    }
    final response = await client.post("$baseUrl/api/progmob/jadwal/update",
        headers: {"content-type": "application/json"},
        body: json.encode({
          "id": idCari,
          "id_dosen": idDosen,
          "id_matkul": idMatkul,
          "nim_progmob": data.nim_progmob
        })
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> deleteJadwal(String id) async{
    final response = await client.post(
        "$baseUrl/api/progmob/jadwal/delete",
        headers: {"content-type": "application/json"},
        body: jsonEncode(<String, String>{
          "id":id,
          "nim_progmob":"72180188"
        })
    );
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }*/

}
