class UserModel {
  String? avatar;
  String phone;
  String? email;
  List<String>? privileges;
  bool? unreadAvailable;
  bool? notificationSound;
  String? userEmail;
  String? name;

  UserModel({
    this.avatar,
    required this.phone,
    this.email,
    this.privileges,
    this.unreadAvailable,
    this.notificationSound,
    this.userEmail,
    this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      avatar: json['avatar'] ?? '',
      phone: json['phone'] as String,
      email: json['email'] ?? '',
      privileges: List<String>.from(json['privileges']) ?? [],
      unreadAvailable: json['unreadAvailable'] ?? false,
      notificationSound: json['notificationSound'] ?? false,
      userEmail: json['userEmail'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'phone': phone,
      'email': email,
      'privileges': privileges,
      'unreadAvailable': unreadAvailable,
      'notificationSound': notificationSound,
      'userEmail': userEmail,
      'name': name,
    };
  }
}
