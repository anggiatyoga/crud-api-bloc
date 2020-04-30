import 'package:crudhttpbloc/src/models/profile_model.dart';
import 'package:crudhttpbloc/src/resources/profile_api_provider.dart';

//Repository sebagai penerus antara fungsi request data dan controller/pemeroses data
class Repository {
  final profileApiProvider = ProfileApiProvider();

  Future<List<Profile>> fetchListProfileRepository() => profileApiProvider.fetchListProfile();
  Future createProfileRepository(Profile profile) => profileApiProvider.createProfile(profile);
  Future updateProfileRepository(Profile profile) => profileApiProvider.updateProfile(profile);
  Future deleteProfileRepository(Profile profile) => profileApiProvider.deleteProfile(profile);

}