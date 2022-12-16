// Project imports:
import 'package:bookrabbit/configs.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String LOCAL = 'LOCAL';
  static const String DEV = 'DEV';
  static const String PROD = 'PROD';

  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      case Environment.LOCAL:
        return LocalConfig();
      default:
        return DevConfig();
    }
  }
}
