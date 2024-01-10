class UserModel {
  String? userId;
  String? avatar;
  String? phone;

  String? userEmail;
  String? name;
  String? fileId;

  UserModel({
    this.avatar,
    required this.phone,
    this.userEmail,
    this.name,
    this.userId,
    this.fileId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      avatar: json['avatar'] ?? '',
      phone: json['email'] ?? '',
      userEmail: json['userEmail'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uniqueId': userId,
      'avatar': avatar,
      'mobile': phone,
      'email': userEmail,
      'name': name,
    };
  }

  Map<String, dynamic> toJsonInput() {
    return {
      'fileId': fileId,
      'phone': phone,
      'fullName': name,
      'email': userEmail,
    };
  }
}
