
import 'package:dio/dio.dart';
import 'package:memory_mate/networking/dio/models%20api/patient_user_api.dart';

import '../../../models/user.dart';
import '../api/dio_exception.dart';

class PatientUserRepository {
  final PatientUserApi patientUserApi;

  PatientUserRepository(this.patientUserApi);

  Future<Map<String, dynamic>> getPatientUserRequest(String userToken) async {
    try {
      final response = await patientUserApi.getPatientUser(userToken);
      String address = (response.data['address']);
      String dOb = (response.data['date_of_birth']);
      String email = (response.data['email']);
      String name = (response.data['full_name']);
      String phone = (response.data['phone']);
      String avtar = (response.data['photo_path']);
      String userType = (response.data['user_type']);

      Map<String, dynamic> patientUser = {
        'name': name,
        'address': address,
        'email': email,
        'phone': phone,
        'avatar': avtar,
        'dob': dOb,
        'userType': userType
      };

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
      String type) async {
    try {
      final response = await patientUserApi.postPatientUser(userName,
          phoneNumber, email, address, dateOfBirth, password, avatar, type);
      return User.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<User> updatePatientUserRequest(
    String token,
    String userName,
    String phoneNumber,
    String email,
    String address,
  ) async {
    try {
      final response = await patientUserApi.updatePatientUser(
        token,
        userName,
        phoneNumber,
        email,
        address,
      );
      return User.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<User> updatePatientUserAvatarRequest(
    String token,
    String avatar,
  ) async {
    try {
      final response = await patientUserApi.updatePatientUserPhoto(
        token,
        avatar,
      );
      return User.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

// OTP
  Future<Response> postOtpRequest(
    String email,
    String token,
  ) async {
    try {
      final response = await patientUserApi.postOtpRequest(email, token);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response> postVerifyOtpRequest(
    String code,
    String token,
  ) async {
    try {
      final response = await patientUserApi.verifyOtpRequest(code, token);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response> postSetNewPasswordRequest(
    String password,
    String token,
  ) async {
    try {
      final response =
          await patientUserApi.setNewPasswordRequest(password, token);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

// memories
  Future<Response> postUserMemoryRequest(
    String location,
    String date,
    String content,
    String avatar,
    String token,
  ) async {
    try {
      final response = await patientUserApi.postPatientMemory(
          location, date, content, avatar, token);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> deleteMemoryUserRequest(String id, String token) async {
    try {
      await patientUserApi.deleteUserMemory(id, token);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List> getUserMemoryRequest(String userToken) async {
    try {
      final response = await patientUserApi.getUserMemories(userToken);
      List userMemories = (response.data['memories']);
      return userMemories;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
