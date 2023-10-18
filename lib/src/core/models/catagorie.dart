import 'package:mawad/src/core/models/image_model.dart';

class CategoryModel {
  final String id;
  final bool status;
  final String nameAr;
  final String nameEng;
  final String? detailsAr;
  final String? detailsEng;
  final ImageModel image;

  CategoryModel({
    required this.id,
    required this.status,
    required this.nameAr,
    required this.nameEng,
    this.detailsAr,
    this.detailsEng,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'],
        status: json['status'],
        nameAr: json['nameAr'],
        nameEng: json['nameEng'],
        detailsAr: json['detailsAr'],
        detailsEng: json['detailsEng'],
        image: json['image'] != null
            ? ImageModel.fromJson(json['image'])
            : ImageModel(
                id: '',
                url: '',
              ));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'nameAr': nameAr,
      'nameEng': nameEng,
      'detailsAr': detailsAr,
      'detailsEng': detailsEng,
      'image': image.toMap(),
    };
  }
}
