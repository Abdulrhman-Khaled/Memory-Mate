import 'package:dio/dio.dart';

import '../../../constants/endpoints_constants.dart';
import '../../../models/user.dart';
import '../api/dio_client.dart';

class PatientUserApi {
  final DioClient dioClient;

  PatientUserApi({required this.dioClient});

  Future<Response> login(email, password) async{
  try{
    final Response response = await dioClient.post(
      "/users/login",
      data:{
        'email':email,
        'password':password
      }
    );
    return response;
  }
  catch(e){
    rethrow;
  }
}

Future<Response> register(User user) async{
  try{
    final Response response = await dioClient.post(
      "/users/register",
      data:user.toJson()
    );
    return response;
  }
  catch(e){
    rethrow;
  }
}

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
      String password,
      String avatar,
      String type,
      ) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.users,
        data: {
          'full_name': userName,
          'phone' : phoneNumber,
          'email' : email,
          'address' : address,
          'date_of_birth' : dateOfBirth,
          'password' : password,
          'photo_path' : avatar,
          'user_type' : type,        
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updatePatientUser(int id, String name) async {
    try {
      final Response response = await dioClient.put(
        '${Endpoints.users}/$id',
        data: {
          'name': name,
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
