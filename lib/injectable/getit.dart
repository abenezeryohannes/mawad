import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'external.package.injection.dart';
import 'getit.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(ExternalPackageInjection),
  ],
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();
