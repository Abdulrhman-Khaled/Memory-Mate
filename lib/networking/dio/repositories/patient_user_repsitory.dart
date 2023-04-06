import 'package:dio/dio.dart';
import 'package:memory_mate/networking/dio/models%20api/patient_user_api.dart';


import '../../../models/user.dart';
import '../api/dio_exception.dart';

class PatientUserRepository {

  final PatientUserApi patientUserApi;
  
  PatientUserRepository(this.patientUserApi);

  Future<List<User>> getPatientUserRequest() async {
    try {
      final response = await patientUserApi.getPatientUser();
      final patientUser = (response.data['data'] as List)
          .map((e) => User.fromJson(e))
          .toList();
      return patientUser;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<User> postPatientUserRequest(
      String userName,
      String phoneNumber,
      String email,
      String address,
      String dateOfBirth,
      String password,
      String avatar,
      String type
      ) async {
    try {
      final response = await patientUserApi.postPatientUser(
          userName,
           phoneNumber,
       email,
       address,
       dateOfBirth,
       password,
       avatar,
       type
          );
      return User.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<User> updatePatientUserRequest(
      int id,
      String userName,
      ) async {
    try {
      final response = await patientUserApi.updatePatientUser(
          id,
          userName,
          );
      return User.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> deletePatientUserRequest(int id) async {
    try {
      await patientUserApi.deletePatientUser(id);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
