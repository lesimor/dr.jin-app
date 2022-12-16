abstract class BaseConfig {
  String get apiHost;
  String get tcpProtocol;
  String get pgParameter;
}

class LocalConfig implements BaseConfig {
  String get apiHost => "localhost:9923";
  String get tcpProtocol => "http";
  String get pgParameter => "html5_inicis.INIpayTest";
}

class DevConfig implements BaseConfig {
  String get apiHost => "34.120.215.196";
  String get tcpProtocol => "http";
  String get pgParameter => "html5_inicis.INIpayTest";
}

class ProdConfig implements BaseConfig {
  String get apiHost => "https://book-rabbit.com";
  String get tcpProtocol => "https";
  String get pgParameter => "html5_inicis";
}
