class UserModel {
  String? userId;
  String? avatar;
  String phone;

  List<String>? privileges;
  bool? unreadAvailable;
  bool? notificationSound;
  String? email;
  String? name;

  UserModel({
    this.avatar,
    required this.phone,
    this.email,
    this.privileges,
    this.unreadAvailable,
    this.notificationSound,
    this.name,
    this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      avatar: json['avatar'] ?? '',
      phone: json['phone'] as String,
      email: json['email'] ?? '',
      privileges: List<String>.from(json['privileges']) ?? [],
      unreadAvailable: json['unreadAvailable'] ?? false,
      notificationSound: json['notificationSound'] ?? false,
      name: json['fullName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'avatar': avatar,
      'phone': phone,
      'email': email,
      'privileges': privileges,
      'unreadAvailable': unreadAvailable,
      'notificationSound': notificationSound,
      'fullName': name,
    };
  }

  Map<String, dynamic> toJsonInput() {
    return {
      'phone': phone,
      'fullName': name,
    };
  }
}
