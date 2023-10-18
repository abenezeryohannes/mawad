class ImageModel {
  final String id;
  final String url;

  ImageModel({required this.id, required this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(id: json['id'], url: json['url']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
    };
  }
}
