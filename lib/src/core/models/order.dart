import 'package:mawad/src/core/models/cart_items.dart';
import 'package:mawad/src/core/models/citie.dart';
import 'package:mawad/src/core/models/user.dart';

class OrderModel {
  final List<CartItem> products;
  final String orderTimeType;
  final String status;
  final String payType;
  final List services;
  final UserData userData;
  final String userId;
  final String deliveryArea;
  final String percentageId;

  OrderModel({
    required this.products,
    required this.orderTimeType,
    required this.status,
    required this.payType,
    required this.services,
    required this.userData,
    required this.userId,
    required this.deliveryArea,
    required this.percentageId,
  });

  //to map
  Map<String, dynamic> toMap() {
    return {
      'products': products.map((x) => x.toMap()).toList(),
      'orderTimeType': orderTimeType,
      'status': status,
      'payType': payType,
      'services': services,
      'userData': userData.toMap(),
      'userId': userId,
      'deliveryArea': deliveryArea,
      'percentageId': percentageId,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      products: List<CartItem>.from(
          json['products'].map((x) => CartItem.fromJson(x))),
      orderTimeType: json['orderTimeType'],
      status: json['status'],
      payType: json['payType'],
      services: json['services'],
      userData: UserData.fromJson(json['userData']),
      userId: json['userId'],
      deliveryArea: json['deliveryArea'],
      percentageId: json['percentageId'],
    );
  }
}

class UserData {
  final UserModel user; // Assuming User is an existing model
  final LocationDetail address; // Assuming Address is an existing model

  UserData({
    required this.user,
    required this.address,
  });

//to map
  Map<String, dynamic> toMap() {
    return {
      ...user.toJson(),
      ...address.toJson(),
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: UserModel.fromJson(json['user']),
      address: LocationDetail.fromJson(json['address']),
    );
  }
}
