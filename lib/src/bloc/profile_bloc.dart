import 'dart:async';

import 'package:crudhttpbloc/src/models/profile_model.dart';
import 'package:crudhttpbloc/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc{

  //properties
  final _repository = Repository();

  //sebagai id pengenal yg nanti dipanggil untuk di proses atau ditampilkan
  final _createProfileController = StreamController<Profile>.broadcast(); // create data profile untuk disimpan list profile
  final _updateProfileController = StreamController<Profile>.broadcast(); // update data profile untuk disimpan list profile
  final _deleteProfileController = StreamController<Profile>.broadcast(); // delete data profile untuk disimpan list profile
  final _listProfileFetcher = PublishSubject<List<Profile>>(); //mendapatkan semua list data

  //input
  StreamSink<Profile> get inCreateProfile => _createProfileController.sink; // data inputan dimasukan kedalam keran controller id _createProfileController
  StreamSink<Profile> get inUpdateProfile => _updateProfileController.sink; // data inputan dimasukan kedalam keran controller id _updateProfileController
  StreamSink<Profile> get inDeleteProfile => _deleteProfileController.sink; // data inputan dimasukan kedalam keran controller id _deleteProfileController

  //Output
  Observable<List<Profile>> get inListProfile => _listProfileFetcher.stream; // data yang diperoleh dari handleFetchListProfile() akan dialirkan / menjadi data output

  // constructor untuk menggunakan fungsi bloc
  ProfileBloc() {
    handleFetchListProfile();
    _createProfileController.stream.listen(_handleCreateProfile);
    _updateProfileController.stream.listen(_handleUpdateProfile);
    _deleteProfileController.stream.listen(_handleDeleteProfile);
  }

  // pemerorses

  handleFetchListProfile() async { // read all list
    List<Profile> profile = await _repository.fetchListProfileRepository();//response dari fungsi repository dimasukan dalam list profile
    _listProfileFetcher.sink.add(profile);//data profile dimasukan ke dalam object data _listProfileFetcher
  }

  _handleCreateProfile(Profile profile) async { // create
    await _repository.createProfileRepository(profile); //response dari fungsi repository data profile yang diterima akan diterukan/dimasukan ke _addProfileController
  }

  _handleUpdateProfile(Profile profile) async { // update
    await _repository.updateProfileRepository(profile); //response dari fungsi repository data profile yang diterima akan diterukan/dimasukan ke _updateProfileController
  }

  _handleDeleteProfile(Profile profile) async { // delete
    await _repository.deleteProfileRepository(profile); //response dari fungsi repository data profile yang diterima akan diterukan/dimasukan ke _deleteProfileController
  }

  // dispose berfungsi untuk menghapus atau membuang data bila tidak digunakan atau data data perubahan
  dispose() {
    _listProfileFetcher.close();
    _createProfileController.close();
    _updateProfileController.close();
    _deleteProfileController.close();
  }
}

final profileBloc = ProfileBloc();