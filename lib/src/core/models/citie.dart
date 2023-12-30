class LocationDetail {
  String? id;
  Area? area;
  City? city;
  String avenue;
  String block;
  String house;
  String street;
  String? areaId;
  String? cityId;

  LocationDetail({
    this.id,
    this.area,
    this.city,
    required this.avenue,
    required this.block,
    required this.house,
    required this.street,
    this.areaId,
    this.cityId,
  });

  //empty constructor

  LocationDetail.empty(
      {this.id,
      this.area,
      this.city,
      this.avenue = '',
      this.block = '',
      this.house = '',
      this.street = '',
      this.areaId,
      this.cityId});

  factory LocationDetail.fromJson(Map<String, dynamic> json) {
    return LocationDetail(
      id: json['id'] ?? '',
      area: Area.fromJson(json['area']),
      city: City.fromJson(json['city']),
      avenue: json['avenue'] ?? '',
      block: json['block'] ?? '',
      house: json['house'] ?? '',
      street: json['street'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area': area?.toJson(),
      'city': city?.toJson(),
      'avenue': avenue,
      'block': block,
      'house': house,
      'street': street,
    };
  }

  Map<String, dynamic> toJsonInput() {
    return {
      'id': id,
      'avenue': avenue,
      'block': block,
      'house': house,
      'street': street,
      'areaId': areaId,
      'cityId': cityId,
    };
  }
}

class City {
  final String cityId;
  final String nameAr;
  final String nameEng;
  final String countryId;

  City({
    required this.cityId,
    required this.nameAr,
    required this.nameEng,
    required this.countryId,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['id'] ?? '',
      nameAr: json['nameAr'] ?? '',
      nameEng: json['nameEng'] ?? '',
      countryId: json['countryId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': cityId,
      'nameAr': nameAr,
      'nameEng': nameEng,
      'countryId': countryId,
    };
  }
}

class Area {
  final String areaId;
  final String nameAr;
  final String nameEng;
  final String cityId;

  Area({
    required this.areaId,
    required this.nameAr,
    required this.nameEng,
    required this.cityId,
  });

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      areaId: json['id'] ?? '',
      nameAr: json['nameAr'] ?? '',
      nameEng: json['nameEng'] ?? '',
      cityId: json['cityId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': areaId,
      'nameAr': nameAr,
      'nameEng': nameEng,
      'cityId': cityId,
    };
  }
}
