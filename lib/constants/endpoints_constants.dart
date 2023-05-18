class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://416f-156-202-113-142.ngrok-free.app";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 20);

  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 20);

  static const String usersRegister = '/users/register';

  static const String users = '/users';

  static const String getUsers = '/users/getuser';

  static const String memories = '/memories';

  static const String contacts = '/usercontacts';
}
