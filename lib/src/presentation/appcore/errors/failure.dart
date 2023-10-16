import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  String? message = "Sorry, Something went wrong, please try again later!";
  static String FIREBASE_KEY =
      "Sorry, Something went wrong, please try again later!";

  Failure({this.message});
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  CacheFailure({super.message});
}

class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure({super.message});
}

class ClientFailure extends Failure {
  ClientFailure({super.message});
}

class NoDataFailure extends Failure {
  NoDataFailure({super.message});
}

class UnExpectedFailure extends Failure {
  UnExpectedFailure({super.message});
}
