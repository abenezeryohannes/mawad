import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class INetworkInfo {
  Future<bool>? get isConnected;
  static const String HostURL = "";
}

@Singleton(as: INetworkInfo)
class NetworkInfoImp implements INetworkInfo {
  late InternetConnection connectionChecker;

  NetworkInfoImp({required this.connectionChecker});

  // @override
  // Future<bool>? get isConnected => connectionChecker.hasInternetAccess;

  @override
  Future<bool>? get isConnected => Future.value(true);
}
