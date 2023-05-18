import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/networking/dio/models%20api/patient_user_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../constants/color_constatnts.dart';
import '../../networking/dio/api/dio_client.dart';
import '../../networking/dio/repositories/patient_user_repsitory.dart';

class MyPatientsScreen extends StatefulWidget {
  const MyPatientsScreen({super.key});

  @override
  State<MyPatientsScreen> createState() => _MyPatientsScreenState();
}

class _MyPatientsScreenState extends State<MyPatientsScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  List<dynamic> patientsList = [];

  late Dio dio;
  late DioClient dioClient;
  late PatientUserApi userApi;
  late PatientUserRepository patientUserRepository;

  String imageLink =
      'https://res.cloudinary.com/dpxzn12st/image/upload/v1682936932/users/o68ka20a9ud9caijqqwe.jpg';

  SimpleFontelicoProgressDialog? prograssDialog;

  bool isLoading = true;

  Response? response;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> refresh() async {
    getUserPatients();
    setState(() {});
    refreshController.refreshCompleted();
  }

  Future<void> getUserPatients() async {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('currentUserToken');
    List<dynamic> userPatients =
        await patientUserRepository.getCaregiverPatientsRequest(userToken!);

    log(userPatients.toString());
    setState(() {
      patientsList = userPatients;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserPatients();
    prograssDialog = SimpleFontelicoProgressDialog(context: context);
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void startAnimation() {
    if (!_controller!.isAnimating) {
      _controller!.forward();
    }
  }

  Future<void> showPrograssDialog() async {
    prograssDialog!
        .show(message: "جاري التحميل...", indicatorColor: AppColors.mintGreen);
  }

  Future<void> hidePrograssDialog() async {
    prograssDialog!.hide();
  }

  @override
  Widget build(BuildContext context) {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: AppColors.mintGreen,
        ),
        centerTitle: true,
        title: const Text(
          'المرضي المتصلين بك',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.mintGreen,
              backgroundColor: AppColors.white,
            ))
          : patientsList.isEmpty
              ? const Center(
                  child: Text(
                    'لم يتم إضافة اي اشخاص بعد',
                    style: TextStyle(fontSize: 22, color: AppColors.mintGreen),
                  ),
                )
              : SmartRefresher(
                  controller: refreshController,
                  enablePullDown: true,
                  onRefresh: refresh,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: patientsList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: const Color.fromARGB(255, 244, 244, 244),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 10, 10),
                                  child: Image(
                                      width: 100,
                                      height: 100,
                                      image: NetworkImage(imageLink)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  patientsList[index]['full_name'],
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  patientsList[index]['email'],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: AppColors.mintGreen,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
    );
  }
}
