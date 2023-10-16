class CacheException implements Exception {
  String? message = "no_connection_error";
  CacheException({this.message = "no_connection_error"});
}

class ServerSideException implements Exception {
  String? message = "server_side_error";

  ServerSideException({this.message = "server_side_error"});
}

class UnExpectedException implements Exception {
  String? message = "un_expected_exception";

  UnExpectedException({this.message = "un_expected_exception"});
}

class NoDataException implements Exception {
  String? message = "no_data_exception";
  NoDataException({this.message = "no_data_exception"});
}

class NetworkException implements Exception {
  String? message = "network_exception";

  NetworkException({this.message = "network_exception"});
}
