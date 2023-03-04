import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:memory_mate/networking/dio/models%20api/patient_user_api.dart';

import '../models/patient_user.dart';
import '../networking/dio/api/dio_client.dart';

import '../networking/dio/repositories/patient_user_repsitory.dart';

class PatientUserController {
  Dio dio = Dio();
  late DioClient dioClient = DioClient(dio);

  late final PatientUserApi patientUserApi =
      PatientUserApi(dioClient: dioClient);

  // --------------- Repository -------------
  late PatientUserRepository patientUserRepository =
      PatientUserRepository(patientUserApi);

  // --------------- Controllers -------------
  final userNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final jobController = TextEditingController();
  final diseaseLevelController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  dynamic avatar = '';
  dynamic age = '';

  // -------------- Local Variables ---------------
  final List<PatientUser> patientUserList = [];

  // -------------- Methods ---------------
  Future<List<PatientUser>> getUsers() async {
    final patientUser = await patientUserRepository.getPatientUserRequest();
    return patientUser;
  }

  Future<PatientUser> postPatientUser() async {
    final newPatientUser = await patientUserRepository.postPatientUserRequest(
        userNameController.text,
        phoneNumberController.text,
        emailController.text,
        addressController.text,
        dateOfBirthController.text,
        jobController.text,
        diseaseLevelController.text,
        passwordController.text,
        avatar,
        age);
    patientUserList.add(newPatientUser);
    return newPatientUser;
  }

  Future<PatientUser> updatePatientUser(
      int id,
      String userName,
      ) async {
    final updatePatientUser =
        await patientUserRepository.updatePatientUserRequest(
            id,
            userName,
            );
    patientUserList[id] = updatePatientUser;
    return updatePatientUser;
  }

  Future<void> deletePatientUser(int id) async {
    await patientUserRepository.deletePatientUserRequest(id);
    patientUserList.removeAt(id);
  }
}
