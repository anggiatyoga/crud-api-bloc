import 'dart:convert';

//model berfungsi untuk menyimpan dan meanggil data atau tempat transit data
class Profile {

  int id;
  String name;
  String email;
  int age;

  Profile({
    this.id,
    this.name,
    this.email,
    this.age
});

  //mengubah json format menjadi string object
  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    age: json["age"]
  );

  //mengubah string object menjadi json format
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "age": age
  };

}

//mengkonversi json format menjadi list profile
List<Profile> profileFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Profile>.from(jsonData.map((x) => Profile.fromJson(x)));
}

//mengkonversi list profile menjadi json format
String profileToJson(Profile profile) {
  final jsonData = profile.toJson();
  return json.encode(jsonData);
}