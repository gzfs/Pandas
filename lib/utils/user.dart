import 'dart:convert';

class User {
  String id = "";
  String userName = "";
  int age = 0;
  String email = "";
  String userGender = "";
  String instagramHandle = "";
  String avatar = "";
  String macAddress = "";

  User(
      {required this.id,
      required this.avatar,
      required this.instagramHandle,
      required this.userGender,
      required this.age,
      required this.userName,
      required this.macAddress});

  User.fromJson(String jsonString) {
    final parsedJson = jsonDecode(jsonString);
    userName = parsedJson["name"];
    age = int.parse(parsedJson["age"]);
    instagramHandle = parsedJson["handle"];
    avatar = parsedJson["image"];
    userGender = parsedJson["gender"];
    macAddress = parsedJson["macAddress"];
  }
}
