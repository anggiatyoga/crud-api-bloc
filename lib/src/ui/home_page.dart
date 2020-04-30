import 'package:crudhttpbloc/src/bloc/profile_bloc.dart';
import 'package:crudhttpbloc/src/models/profile_model.dart';
import 'package:crudhttpbloc/src/ui/add_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {// inisialisasi awal sebelum view dibentuk
    profileBloc.handleFetchListProfile(); // inisialisasi list profile
    super.initState();
  }

  @override
  void dispose() {// close bila view sudah selesai
    profileBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile List'),
      ),
      body: Container(
        child: StreamBuilder<List<Profile>>(// data bloc yg ingin digunakan harus dibangun dari StreamBuilder
          stream: profileBloc.inListProfile, // aliran data berisi list data profile
          builder: (context, AsyncSnapshot<List<Profile>> snapshot) {// builder dipasang dalam context lalu disi oleh List<Profile> secara Async  dgn nama obj snapshot
            if (snapshot.hasData) {
              // jika data ditemukan
              return buildList(snapshot); // data/snapshot akan masuk kedalam widget ListView.builder
            } else if (snapshot.hasError) {// jika data eror
              return Center(
                child: Text(snapshot.error.toString()), // cetak text eror
              );
            }
            return Center(
              child: CircularProgressIndicator(), // jika loading / reload data
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPage(
                        profile:
                            null, // dipasang null karena button ini ingin membuat data baru
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<Profile>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length, // jumlah item list menyesuaikan panjang/jumlah snapshot.data
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddPage(
                  profile: snapshot.data[index], // mengirim data profile sesuai dengan index nya
                );
              }));
            },
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: FlutterLogo(
                  size: 50.0,
                ),
                title: Text(
                  snapshot.data[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(snapshot.data[index].email),
                    Text(snapshot.data[index].age.toString())
                  ],
                ),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      profileBloc.inDeleteProfile.add(snapshot.data[index]); // menjalan fungsi bloc delete dan memasukan parameter profil data nya
                      await Future.delayed(const Duration(milliseconds: 500)); // mereload ui dengan durasi respon tampilan 500 milliseconds
                      profileBloc.handleFetchListProfile(); // mereload kembali semua list profile
                      setState(() {}); // update perubahanya
                      Fluttertoast.showToast( // untuk menampilkan pesan dari action ini
                          msg: "Delete ${snapshot.data[index].name} Succses",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.greenAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }),
              ),
            )),
          );
        });
  }
}
