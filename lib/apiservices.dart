import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:peterpan_app2/model.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class apiservices {
  final String baseUrl = "http://192.168.100.9/peterpensianji/aplikasi-slim/public";

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
  //Menampilkan semua mahasiswa
  Future<List<Mahasiswa>> getMhs() async{
    final response = await client.get("$baseUrl/MahasiswaGetAll/");
    if (response.body.isNotEmpty){
      return mahasiswaFromJson(response.body);
    }else{
      return null;
    }
  }

  //Melihat daftar janjian yang dimiliki dosen
  Future<List<Janjian>> viewJanjianbyNidn(String nidn) async {
    final response = await client.get("$baseUrl/Mhs/LihatJanjianDosen/"+nidn);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }

  //Melihat daftar janjian yang dimiliki Mahasiswa
  Future<List<Janjian>> viewJanjianbyNim(String nim) async {
    final response = await client.get("$baseUrl/Mhs/JanjianbyNim/"+nim);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }

// ----------- UserGoogle ----------- //

  Future<List<UserGoogle>> getUser() async{
    final response = await client.get("$baseUrl/UserGoogle/getall");
    if (response.body.isNotEmpty){
      return UserGoogleFromJson(response.body);
    }else{
      return null;
    }
  }



  Future<bool> createSession(UserGoogle data) async{
    final response = await client.post("$baseUrl/UserGoogle/Add/",
        headers: {"content-type": "application/json"},
        body: UserGoogleToJson(data)
    );
    if(response.statusCode ==200){
      return true;
    }else{
      return false;
    }
  }
  Future <List<UserGoogle>> validate (UserGoogle data) async{
    final response = await client.post("$baseUrl/UserGoogle/Validate",
        headers: {"content-type": "application/json"},
        body: UserGoogleToJson(data)
    );

    if(response.statusCode == 200){
      return UserGoogleFromJson(response.body);

    }
    else
      {
        return null;
      }
  }
  Future<bool> validateUser(String username) async{
    final response = await client.get("$baseUrl/UserGoogle/"+username);
    if (response.body != null){
      return true;
    }else{
      return null;
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

  //Menampilkan jadwal berdasarkan nidn
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
    final response = await client.post("$baseUrl/Dosen/Register/",
        headers: {"content-type": "application/json"},
        body: dosenToJson(data)
    );
    if(response.statusCode ==200){
      return true;
    }else{
      return false;
    }
  }

  //Dosen Lihat janjian yang masih tersedia

  Future<List<Janjian>> viewJanjianTersdiabyNidn(String nidn) async {
    final response = await client.get("$baseUrl/Dosen/LihatJanjianTersedia/"+nidn);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }





  // ----------- Janjian ----------- //
  Future<bool> mhsCreateJanjian(Janjian data) async{
    final response = await client.post("$baseUrl/Mhs/CreateJanjian/",
        headers: {"content-type": "application/json"},
        body: janjianToJson(data)
    );
    if(response.statusCode ==200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> dosenCreateJanjian(Janjian data) async{
    final response = await client.post("$baseUrl/Dosen/CreateJanjian/",
        headers: {"content-type": "application/json"},
        body: janjianToJson(data)
    );
    if(response.statusCode ==200){
      return true;
    }else{
      return false;
    }
  }

  Future<List<Janjian>> viewJanjianDisetujui(String nim) async {
    final response = await client.get("$baseUrl/Mhs/JanjianDisetujui/"+nim);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<List<Janjian>> viewJanjianDitolak(String nim) async {
    final response = await client.get("$baseUrl/Mhs/JanjianDitolak/"+nim);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }


  Future<List<Janjian>> viewJanjianbyKode(String kd_janjian) async {
    final response = await client.get("$baseUrl/Mhs/ShowJanjianByKodeJanjian/"+kd_janjian);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<bool> deleteJanjian(String kd_janjian) async{
    final response = await client.delete("$baseUrl/Mhs/DeleteJanjian/"+kd_janjian);
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> mhsAjukanJdwlJanji(Janjian data, String kd_janjian) async {
    final response = await client.post("$baseUrl/Mhs/UpdateJanjian/",
        headers: {"content-type": "application/json"},
        body: json.encode({
          "kd_janjian": data.kd_janjian,
          "nim": data.nim,
          "nidn": data.nidn,
          "tgl": data.tgl,
          "jam": data.jam,
          "tempat": data.tempat,
          "ketJanjian": data.ketJanjian,
          "sttsJanjian": data.sttsJanjian,
          "isAvailable": data.isAvailable,
          "createdBy" : data.createdBy
        })
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Janjian>> viewJanjianCreatedbyDosen(String nidn) async {
    final response = await client.get("$baseUrl/Janjian/Created/Dosen/"+nidn);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<List<Janjian>> viewJanjianCreatedbyNim(String nidn) async {
    final response = await client.get("$baseUrl/Janjian/Created/mhs/"+nidn);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<List<Janjian>> viewJanjianAllDsn(String nidn) async {
    final response = await client.get("$baseUrl/DosenViewAllJanjian/"+nidn);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }


  Future<bool> dosenUpdateJanjian(Janjian data, String kd_janjian) async {
    final response = await client.post("$baseUrl/Dosen/UpdateJanjian/",
        headers: {"content-type": "application/json"},
        body: json.encode({
          "kd_janjian": data.kd_janjian,
          "nim": data.nim,
          "nidn": data.nidn,
          "tgl": data.tgl,
          "jam": data.jam,
          "tempat": data.tempat,
          "ketJanjian": data.ketJanjian,
          "sttsJanjian": data.sttsJanjian,
          "isAvailable": data.isAvailable,
          "createdBy" : data.createdBy
        })
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Janjian>> dosenBatalkanJanji(String kd_janjian) async {
    final response = await client.get("$baseUrl/Dosen/BatalkanJanjian/"+kd_janjian);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<List<Janjian>> verifikasiJanjianTerima(String kd_janjian) async {
    final response = await client.get("$baseUrl/Dosen/VerifikasiJanjian/"+kd_janjian);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }
  Future<List<Janjian>> verifikasiJanjianTolak(String kd_janjian) async {
    final response = await client.get("$baseUrl/Dosen/VerifikasiJanjian/tolak/"+kd_janjian);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<List<Janjian>> ViewJanjianMenuggu(String nidn) async {
    final response = await client.get("$baseUrl/Dosen/verifikasi/"+nidn);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }

  //Melihat daftar janjian yang dimiliki dosen
  Future<List<Janjian>> viewJanjianByDosenTersedia(String nidn) async {
    final response = await client.get("$baseUrl/Dosen/LihatJanjianDosenTersedia/"+nidn);
    if (response.body.isNotEmpty){
      return janjianFromJson(response.body);
    }else{
      return null;
    }
  }





























  /*
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
