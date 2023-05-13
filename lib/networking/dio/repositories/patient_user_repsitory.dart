import 'package:dio/dio.dart';
import 'package:memory_mate/networking/dio/models%20api/patient_user_api.dart';

import '../../../models/user.dart';
import '../api/dio_exception.dart';

class PatientUserRepository {
  final PatientUserApi patientUserApi;

  PatientUserRepository(this.patientUserApi);

// Pateint User
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

// Memories
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

  Future<Response> getUserMemoryRequest(String userToken) async {
    try {
      final response = await patientUserApi.getUserMemories(userToken);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

// Link with Caregiver
  Future<Map<String, dynamic>> linkWithCaregiverRequest(
    String bio,
    String relation,
    String email,
    String token,
  ) async {
    try {
      final response =
          await patientUserApi.linkWithCaregiver(bio, relation, email, token);
      Map<String, dynamic> caregiverInfoList = response.data;
      return caregiverInfoList;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List> getPatientCaregiversRequest(String userToken) async {
    try {
      final response = await patientUserApi.getPatientCaregivers(userToken);
      List userCaregivers = (response.data);
      return userCaregivers;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<void> deleteCaregiverRequest(String id, String token) async {
    try {
      await patientUserApi.deleteCaregiver(id, token);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List> getCaregiverPatientsRequest(String userToken) async {
    try {
      final response = await patientUserApi.getCaregiverPatients(userToken);
      List userPatients = (response.data);
      return userPatients;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

// Fcaes add and Detection with AI
  Future<List> getUserAllFaces(String userToken) async {
    try {
      final response = await patientUserApi.getPatientFaces(userToken);
      List userFaces = (response.data);
      return userFaces;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response> postUserNewFaceRequest(
    String name,
    String bio,
    String face,
    String token,
  ) async {
    try {
      final response =
          await patientUserApi.postPtientNewface(name, bio, face, token);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Map<String, dynamic>> postFaceToDetectRequest(
    String face,
    String token,
  ) async {
    try {
      final response = await patientUserApi.postFaceToDetect(face, token);
      Map<String, dynamic> detectionResult = (response.data['Person Info']);
      return detectionResult;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response> postXRayToDetectRequest(
    String xRay,
  ) async {
    try {
      final response = await patientUserApi.postXRayToDetect(xRay);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

// post and get location
  Future<Response> postUserLocationRequest(
    double lat,
    double lng,
    String token,
  ) async {
    try {
      final response = await patientUserApi.postUserLocation(lat, lng, token);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List> getSecondUserLocationRequest(String userToken) async {
    try {
      final response = await patientUserApi.getUserLocation(userToken);
      List secondUser = (response.data);
      return secondUser;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
