import 'package:crudhttpbloc/src/models/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

//ProfileApiProvider merupakan controller untuk melakukan proses request ke api
class ProfileApiProvider{
  Client client = Client();
  final _baseUrl = "https://amanahku-heroku-demo.herokuapp.com";

  //melihat semua data profile dalam bentuk list
  Future<List<Profile>> fetchListProfile() async {
    final response = await client.get("$_baseUrl/untukbelajar/showall"); //request ke endpoint "/untukbelajar/showall" dgn method "get"
    if(response.statusCode == 200) { // jika berhsil maka response akan dan di proses oleh profileFromJson()
      return compute(profileFromJson, response.body); //fungsi compute untuk menjalankan fetchListProfile dalam isolasi terpisah / latarbelakang.
    } else {
      throw Exception('Failed to load'); // mengirim pesan eror bila gagal request atau response tidak diterima
    }
  }

  //menambahkan data profile
  Future createProfile(Profile profile) async {
    final response = await client.post(
      "$_baseUrl/untukbelajar/create", //request ke endpoint "/untukbelajar/create" dgn method "post"
      headers: {"content-type":"application/json"}, // mengirim data ke body dengan format json
      body: profileToJson(profile) // data yang dimasukan dalam body request, dalam format json
    );
    if(response.statusCode == 200) { // jika 200 maka proses request api berhasil
      return response; // mengembalikan hasil response/data dari request api dan akan di proses oleh addProfileRepository()
    } else {
      throw Exception("Failed to add profile"); // mengirim pesan eror bila gagal request atau response tidak diterima
    }
  }

  //mengubah data profile
  Future updateProfile(Profile profile) async {
    final response = await client.post(
        "$_baseUrl/untukbelajar/update", //request ke endpoint "/untukbelajar/update" dgn method "post"
        headers: {"content-type":"application/json"}, // mengirim data ke body dengan format json
        body: profileToJson(profile) // data yang dimasukan dalam body request, dalam format json
    );
    if(response.statusCode == 200) { // jika 200 maka proses request api berhasil
      return response; // mengembalikan hasil response/data dari request api dan akan di proses oleh updateProfileRepository()
    } else {
      throw Exception("Failed to add profile"); // mengirim pesan eror bila gagal request atau response tidak diterima
    }
  }

  //menghapus data profile
  Future deleteProfile(Profile profile) async {
    final response = await client.post(
        "$_baseUrl/untukbelajar/delete", //request ke endpoint "/untukbelajar/delete" dgn method "post"
        headers: {"content-type":"application/json"}, // mengirim data ke body dengan format json
        body: profileToJson(profile) // data yang dimasukan dalam body request, dalam format json
    );
    if(response.statusCode == 200) { // jika 200 maka proses request api berhasil
      return response; // mengembalikan hasil response/data dari request api dan akan di proses oleh deleteProfileRepository()
    } else {
      throw Exception("Failed to add profile"); // mengirim pesan eror bila gagal request atau response tidak diterima
    }
  }




}




