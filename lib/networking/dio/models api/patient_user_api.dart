import 'package:dio/dio.dart';

import '../../../constants/endpoints_constants.dart';
import '../../../models/user.dart';
import '../api/dio_client.dart';

class PatientUserApi {
  final DioClient dioClient;

  PatientUserApi({required this.dioClient});

  Future<Response> login(email, password) async {
    try {
      final Response response = await dioClient
          .post("/users/login", data: {'email': email, 'password': password});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> register(User user) async {
    try {
      final Response response =
          await dioClient.post("/users/register", data: user.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getPatientUser(String userToken) async {
    try {
      final Response response =
          await dioClient.get(Endpoints.getUsers, userToken: userToken);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postPatientUser(
    String userName,
    String phoneNumber,
    String email,
    String address,
    String dateOfBirth,
    String password,
    String avatar,
    String type,
  ) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.users,
        data: {
          'full_name': userName,
          'phone': phoneNumber,
          'email': email,
          'address': address,
          'date_of_birth': dateOfBirth,
          'password': password,
          'photo_path': avatar,
          'user_type': type,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updatePatientUser(
    String token,
    String userName,
    String phoneNumber,
    String email,
    String address,
  ) async {
    try {
      final Response response = await dioClient.patch(
        '${Endpoints.users}/patchuser',
        userToken: token,
        data: {
          'address': address,
          'email': email,
          'full_name': userName,
          'phone': phoneNumber,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updatePatientUserPhoto(
    String token,
    String avatar,
  ) async {
    try {
      final Response response = await dioClient.patch(
        '${Endpoints.users}/changephoto',
        userToken: token,
        data: {
          'img': avatar,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

// OTP
  Future<Response> postOtpRequest(
    String email,
    String token,
  ) async {
    try {
      final Response response = await dioClient.post(
        '${Endpoints.users}/sendOTP',
        userToken: token,
        data: {'email': email, 'channel': 'sms'},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

   Future<Response> verifyOtpRequest(
    String code,
    String token,
  ) async {
    try {
      final Response response = await dioClient.post(
        '${Endpoints.users}/verify',
        userToken: token,
        data: {'verificationcode': code},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> setNewPasswordRequest(
    String password,
    String token,
  ) async {
    try {
      final Response response = await dioClient.post(
        '${Endpoints.users}/newpass',
        userToken: token,
        data: {'password': password},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

// memories
  Future<Response> getUserMemories(String userToken) async {
    try {
      final Response response = await dioClient
          .get('${Endpoints.memories}/usermemoget', userToken: userToken);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserMemory(String id, String token) async {
    try {
      await dioClient.delete('${Endpoints.memories}/memodel/$id',
          userToken: token);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postPatientMemory(
    String location,
    String date,
    String content,
    String avatar,
    String token,
  ) async {
    try {
      final Response response = await dioClient.post(
        "${Endpoints.memories}/memoadd",
        userToken: token,
        data: {
          'title': location,
          'memo_body': content,
          'memo_date': date,
          'thumbnail': avatar,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
