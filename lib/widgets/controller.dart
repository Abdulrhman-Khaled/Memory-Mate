import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/new_user.dart';
import '../models/patient_user.dart';
import '../networking/api/dio_client.dart';
import '../networking/models api/user_api.dart';
import '../networking/repository/user_repository.dart';

class HomeController {
  Dio dio = Dio();
  late DioClient dioClient = DioClient(dio);

  late final UserApi userApi = UserApi(dioClient: dioClient);

  // --------------- Repository -------------
  late UserRepository userRepository = UserRepository(userApi);

  // -------------- Textfield Controller ---------------
  final nameController = TextEditingController();
  final jobController = TextEditingController();

  // -------------- Local Variables ---------------
  final List<NewUser> newUsers = [];

  // -------------- Methods ---------------

  Future<List<UserModel>> getUsers() async {
    final users = await userRepository.getUsersRequested();
    return users;
  }

  Future<NewUser> addNewUser() async {
    final newlyAddedUser = await userRepository.addNewUserRequested(
      nameController.text,
      jobController.text,
    );
    newUsers.add(newlyAddedUser);
    return newlyAddedUser;
  }

  Future<NewUser> updateUser(int id, String name, String job) async {
    final updatedUser = await userRepository.updateUserRequested(
      id,
      name,
      job,
    );
    newUsers[id] = updatedUser;
    return updatedUser;
  }

  Future<void> deleteNewUser(int id) async {
    await userRepository.deleteNewUserRequested(id);
    newUsers.removeAt(id);
  }
}
