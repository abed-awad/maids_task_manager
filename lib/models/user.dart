class UserModel {
  final int id;
  final String username;
  final String token;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String image;

  const UserModel({
    required this.id,
    required this.username,
    required this.token,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'token': token,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      username: map['username'] ?? "",
      token: map['token'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      email: map['email'] ?? "",
      gender: map['gender'] ?? "",
      image: map['image'] ?? "",
    );
  }
}
