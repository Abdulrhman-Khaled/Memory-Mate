class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://192.168.1.2:5000";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  static const String users = '/users';
}