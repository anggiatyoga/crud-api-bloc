import 'package:crudhttpbloc/src/bloc/profile_bloc.dart';
import 'package:crudhttpbloc/src/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPage extends StatefulWidget {
  Profile profile;
  AddPage({this.profile});//constructor untuk mendapatkan data dari layout sebelumnya

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //properties untuk menangani kolom inputan
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();

  @override
  void initState() {
    if(widget.profile != null) { // jika layout sebelumnya terdapat data maka data dipasang ke controller untuk inisialisasi tampilan awal
      _controllerName.text = widget.profile.name.toString();
      _controllerEmail.text = widget.profile.email.toString();
      _controllerAge.text = widget.profile.age.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.profile != null? Text("Update ${widget.profile.name}") : Text("Add new profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _controllerName,
              maxLines: 1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: _controllerEmail,
              maxLines: 1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: _controllerAge,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Age'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: RaisedButton(
                onPressed: () {
                  savePressed();
                },
                child: Center(child: Text('Save')),
              ),
            )
          ],
        ),
      ),
    );
  }

  void savePressed() async {
    //hasil inputan dari form textfield di tangkap kedalam variable
    String getName = _controllerName.value.text.toString();
    String getEmail = _controllerEmail.value.text.toString();
    String getAge = _controllerAge.value.text.toString();

    //inisialisasi untuk profile model
    Profile profile = new Profile();

    if(getName.isNotEmpty && getEmail.isNotEmpty && getAge != null) { // bila data nya tidak kosong atau field form nya tidak di isi
      if(widget.profile != null) { // untuk update karena mendapatkan data dari layout sebelumnya
        profile = new Profile(id: widget.profile.id, name: getName, email: getEmail, age: int.parse(getAge)); //masukan data baru ke dalam model profile dan id data dari data layout sebelumya widget.profile.id

        profileBloc.inUpdateProfile.add(profile); // menjalan fungsi bloc update dan memasukan parameter profil data yg baru yg telah diinisialisasi
        await Future.delayed(const Duration(milliseconds: 500)); // mereload ui dengan durasi respon tampilan 500 milliseconds
        profileBloc.handleFetchListProfile(); // mereload kembali semua list profile
        Navigator.of(context).pop(); // menuju layout sebelum nya yaitu home

        Fluttertoast.showToast( // untuk menampilkan pesan dari action ini
            msg: "Update ${profile.name} Succses",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        profile = new Profile(name: getName, email: getEmail, age: int.parse(getAge));//masukan data baru ke dalam model profile dan id dikosongkan karena id nya otomatis dibuat

        profileBloc.inCreateProfile.add(profile); // menjalan fungsi bloc update dan memasukan parameter profil data yg baru yg telah diinisialisasi
        await Future.delayed(const Duration(milliseconds: 500)); // mereload ui dengan durasi respon tampilan 500 milliseconds
        profileBloc.handleFetchListProfile(); // mereload kembali semua list profile
        Navigator.of(context).pop(); // menuju layout sebelum nya yaitu home

        Fluttertoast.showToast( // untuk menampilkan pesan dari action ini
            msg: "Create ${profile.name} Succses",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    } else {
      Fluttertoast.showToast( // untuk menampilkan pesan dari action ini
          msg: "Field is null",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

}
