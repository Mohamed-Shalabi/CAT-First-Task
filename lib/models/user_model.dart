class UserModel {
  final String name;
  final String email;
  final int phone;
  final String password;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        email = map['email'],
        phone = map['phone'],
        password = map['password'];

  Map<String, dynamic> toMap() {
    return {
      '"name"': '"$name"',
      '"email"': '"$email"',
      '"phone"': phone,
      '"password"': '"$password"',
    };
  }
}
