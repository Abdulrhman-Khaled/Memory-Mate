
import '../api/dio_exception.dart';
import 'package:memory_mate/networking/dio/models%20api/patient_user_api.dart';
import '../../../models/user.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final PatientUserApi userApi;
  AuthRepository(this.userApi);
  Future<String> login(email, password) async {
    try {
      final response = await userApi.login(email, password);
      final token = response.data['data'];
      return token;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> register(User user) async {
    try {
      final response = await userApi.register(user);
      final token = response.data['data'];
      return token;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
      

    }
  }
}
