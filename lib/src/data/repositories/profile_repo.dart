//create repository for profile

import 'dart:developer';

import 'package:mawad/src/core/models/citie.dart';
import 'package:mawad/src/data/services/api_serives.dart';

class ProfileRepo {
  final ApiService _apiService = ApiService();
  Future<List<City>> getCity(String id) async {
    try {
      final result = await _apiService.getRequest('/country/city/get/$id');
      log('getCityresult==>: $result');
      return mapCity(result['data']);
    } catch (error) {
      rethrow;
    }
  }

  List<City> mapCity(List<dynamic> data) {
    return data.map((json) => City.fromJson(json)).toList();
  }

  Future<List<Area>> getArea(String id) async {
    try {
      final result = await _apiService.getRequest('/country/city/area/get/$id');
      return mapAre(result['data']);
    } catch (error) {
      rethrow;
    }
  }

  List<Area> mapAre(List<dynamic> data) {
    return data.map((json) => Area.fromJson(json)).toList();
  }

  Future<List<LocationDetail>> getLocationDetail() async {
    try {
      final result = await _apiService.getRequest('/user/address');
      return mapLocation(result['data']);
    } catch (error) {
      log("getLocationDetail: $error");
      rethrow;
    }
  }

  List<LocationDetail> mapLocation(List<dynamic> data) {
    return data.map((json) => LocationDetail.fromJson(json)).toList();
  }

  //add location detail
  Future<bool> addLocationDetail(LocationDetail locationDetail) async {
    try {
      final result = await _apiService.postRequest(
          '/user/address', locationDetail.toJsonInput());
      return result['success'];
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> updateLocationDetail(LocationDetail locationDetail) async {
    try {
      final result = await _apiService.postRequest(
          '/user/address/${locationDetail.id}', locationDetail.toJsonInput());
      return result['success'];
    } catch (error) {
      rethrow;
    }
  }
}
