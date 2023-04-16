import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/views/profile/update_profile_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/buttons.dart';
import '../../constants/color_constatnts.dart';
import '../../networking/dio/api/dio_client.dart';
import '../../networking/dio/models api/patient_user_api.dart';
import '../../networking/dio/repositories/patient_user_repsitory.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Dio dio;
  late DioClient dioClient;
  late PatientUserApi userApi;
  late PatientUserRepository patientUserRepository;

  String userName = '';

  String imageLink = '';

  String address = '';

  String age = '';

  String phone = '';

  String email = '';

  String type = '';

  bool isLoading = true;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> refresh() async {
    getUserInfo();
    setState(() {});
    refreshController.refreshCompleted();
  }

  String ageCalculator(String date) {
    String dateString = date;
    DateTime birthDate = DateTime.parse(dateString);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('currentUserToken');
    Map<String, dynamic> userInformation =
        await patientUserRepository.getPatientUserRequest(userToken!);
    String dob = ageCalculator(userInformation['dob']);

    log(userInformation.toString());
    setState(() {
      userName = userInformation['name'];
      imageLink = userInformation['avatar'];
      address = userInformation['address'];
      email = userInformation['email'];
      type = userInformation['userType'];
      phone = userInformation['phone'];

      age = dob;
      isLoading = false;
    });

    return userInformation;
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mintGreen,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.mintGreen,
                backgroundColor: AppColors.white,
              ))
            : SmartRefresher(
                controller: refreshController,
                enablePullDown: true,
                onRefresh: refresh,
                child: Column(children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          'assets/images/pictures/bar_tree.png',
                          height: 150.0,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        alignment: Alignment.center,
                        child: const Text(
                          'الملف الشخصي',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 85, 0, 0),
                          alignment: Alignment.center,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                imageLink,
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ))),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60.0),
                            topRight: Radius.circular(60.0))),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  width: 280.0,
                                  padding: const EdgeInsets.all(15.0),
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 245, 245, 245),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      'الأسم : $userName',
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.lightBlack),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.person_outlined,
                                color: AppColors.mintGreen,
                                size: 30,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  width: 280.0,
                                  padding: const EdgeInsets.all(15.0),
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 245, 245, 245),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      'العمر : $age عام',
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.lightBlack),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: AppColors.mintGreen,
                                size: 30.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  width: 280.0,
                                  padding: const EdgeInsets.all(15.0),
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 245, 245, 245),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        const Text(
                                          'رقم الهاتف  : ',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.lightBlack),
                                        ),
                                        Text(
                                          phone,
                                          textDirection: TextDirection.ltr,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: AppColors.lightBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.phone_iphone_outlined,
                                color: AppColors.mintGreen,
                                size: 30.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  width: 280.0,
                                  padding: const EdgeInsets.all(15.0),
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 245, 245, 245),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      'الإيميل  :  $email',
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.lightBlack),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.email_outlined,
                                color: AppColors.mintGreen,
                                size: 30.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  width: 280.0,
                                  padding: const EdgeInsets.all(15.0),
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 245, 245, 245),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      'العنوان : $address',
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.lightBlack,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.location_on_outlined,
                                color: AppColors.mintGreen,
                                size: 30.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  width: 280.0,
                                  padding: const EdgeInsets.all(15.0),
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 245, 245, 245),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: type == 'PATIENT'
                                          ? const Text(
                                              'الفئة : مريض',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.lightBlack),
                                            )
                                          : const Text(
                                              'الفئة : مقدم رعاية',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.lightBlack),
                                            )),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.merge_type_rounded,
                                color: AppColors.mintGreen,
                                size: 30.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: filledButton(
                              width: 308,
                              height: 50,
                              textSize: 20,
                              buttonText: 'تحديث الملف الشخصي',
                              function: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: UpdateProfileScreen(
                                        userName: userName,
                                        address: address,
                                        age: age,
                                        type: type == 'PATIENT'
                                            ? 'مريض'
                                            : 'مقدم رعاية',
                                        phone: phone,
                                        email: email,
                                        imageLink: imageLink,
                                      )),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
                ]),
              ));
  }
}
