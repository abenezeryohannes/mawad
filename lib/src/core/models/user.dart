class User {
  final String id;
  final String phone;
  final String? email;
  final String? name;

  User({required this.id, required this.phone, required this.email, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      phone: json['phone'],
      email: json['email'],
      name: json['name'],
    );
  }
}
