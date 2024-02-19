class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String age;
  final List<String> images;
  final String avatar;

  const UserModel(
      {required this.age,
      required this.email,
      required this.gender,
      required this.name,
      required this.phone,
      this.images = const [],
      this.avatar = "",
      required this.id});

  toJson() {
    return {
      "images": images,
      "avatar": avatar,
      "id": id,
      "email": email,
      "name": name,
      "phone": phone,
      "age": age,
      "gender": gender
    };
  }
}
