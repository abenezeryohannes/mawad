class Country {
  final String id;
  final String nameAr;
  final String nameEng;
  final Attachment attachment;

  Country(
      {required this.id,
      required this.nameAr,
      required this.nameEng,
      required this.attachment});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      nameAr: json['nameAr'],
      nameEng: json['nameEng'],
      attachment: Attachment.fromJson(json['attachment']),
    );
  }
}

class Attachment {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String originalName;
  final String name;
  final int fileSize;
  final String contentType;
  final String? url;

  Attachment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.originalName,
    required this.name,
    required this.fileSize,
    required this.contentType,
    this.url,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      originalName: json['originalName'],
      name: json['name'],
      fileSize: json['fileSize'],
      contentType: json['contentType'],
      url: json['url'],
    );
  }
}
