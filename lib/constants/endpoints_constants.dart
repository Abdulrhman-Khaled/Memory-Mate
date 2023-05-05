class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://memorymate.herokuapp.com";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 20);

  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 20);

  static const String usersRegister = '/users/register';

  static const String users = '/users';

  static const String getUsers = '/users/getuser';

  static const String memories = '/memories';
}
