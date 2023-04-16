import 'package:shared_preferences/shared_preferences.dart';

import '../api/dio_exception.dart';
import 'package:memory_mate/networking/dio/models%20api/patient_user_api.dart';
import '../../../models/user.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  
  final PatientUserApi userApi;
  AuthRepository(this.userApi);
  Future<Response> login(email, password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response = await userApi.login(email, password);
      prefs.setBool('isLoggedIn', true);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response> register(User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Response response = await userApi.register(user);
      prefs.setBool('isLoggedIn', true);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
