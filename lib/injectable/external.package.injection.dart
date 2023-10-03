import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ExternalPackageInjection extends MicroPackageModule {
  @override
  FutureOr<void> init(GetItHelper gh) async {
    gh.singleton<http.Client>(http.Client());
    gh.singleton<InternetConnection>(InternetConnection());

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    gh.singleton<SharedPreferences>(sharedPreferences);
  }
}
