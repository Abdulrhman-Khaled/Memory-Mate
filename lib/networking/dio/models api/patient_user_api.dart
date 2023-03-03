import 'package:dio/dio.dart';

import '../../../constants/endpoints_constants.dart';
import '../api/dio_client.dart';

class PatientUserApi {
  final DioClient dioClient;

  PatientUserApi({required this.dioClient});

  Future<Response> getPatientUser() async {
    try {
      final Response response = await dioClient.get(Endpoints.users);
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
      String job,
      String diseaseLevel,
      String password,
      String avatar,
      int age) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.users,
        data: {
          'user_name': userName,
          'phone_number': phoneNumber,
          'email': email,
          'address': address,
          'date_of_birth': dateOfBirth,
          'job': job,
          'disease_level': diseaseLevel,
          'password': password,
          'avatar': avatar,
          'age': age,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> putPatientUser(
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
      final Response response = await dioClient.put(
        '${Endpoints.users}/$id',
        data: {
          'user_name': userName,
          'phone_number': phoneNumber,
          'email': email,
          'address': address,
          'date_of_birth': dateOfBirth,
          'job': job,
          'disease_level': diseaseLevel,
          'password': password,
          'avatar': avatar,
          'age': age,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePatientUser(int id) async {
    try {
      await dioClient.delete('${Endpoints.users}/$id');
    } catch (e) {
      rethrow;
    }
  }
}
