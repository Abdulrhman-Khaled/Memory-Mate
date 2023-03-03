import 'package:dio/dio.dart';
import 'package:memory_mate/networking/dio/models%20api/patient_user_api.dart';

import '../../../models/patient_user.dart';
import '../api/dio_exception.dart';

class PatientUserRepository {

  final PatientUserApi patientUserApi;
  
  PatientUserRepository(this.patientUserApi);

  Future<List<PatientUser>> getPatientUserRequest() async {
    try {
      final response = await patientUserApi.getPatientUser();
      final patientUsers = (response.data['data'] as List)
          .map((e) => PatientUser.fromJson(e))
          .toList();
      return patientUsers;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<PatientUser> postPatientUserRequest(
      String userName,
      String phoneNumber,
      String email,
      String address,
      String dateOfBirth,
      String job,
      String diseaseLevel,
      String password,
      String avatar,
      int age) async {
    try {
      final response = await patientUserApi.postPatientUser(
          userName,
          phoneNumber,
          email,
          address,
          dateOfBirth,
          job,
          diseaseLevel,
          password,
          avatar,
          age);
      return PatientUser.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<PatientUser> updatePatientUserRequest(
      int id,
      String userName,
      String phoneNumber,
      String email,
      String address,
      String dateOfBirth,
      String job,
      String diseaseLevel,
      String password,
      String avatar,
      int age) async {
    try {
      final response = await patientUserApi.putPatientUser(
          id,
          userName,
          phoneNumber,
          email,
          address,
          dateOfBirth,
          job,
          diseaseLevel,
          password,
          avatar,
          age);
      return PatientUser.fromJson(response.data);
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
