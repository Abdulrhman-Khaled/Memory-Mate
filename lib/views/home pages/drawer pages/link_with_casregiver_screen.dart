import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../../components/buttons.dart';
import '../../../components/text_fields.dart';
import '../../../constants/color_constatnts.dart';
import '../../../networking/dio/api/dio_client.dart';
import '../../../networking/dio/models api/patient_user_api.dart';
import '../../../networking/dio/repositories/patient_user_repsitory.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class LinkWithCaregiverScreen extends StatefulWidget {
  const LinkWithCaregiverScreen({super.key});

  @override
  State<LinkWithCaregiverScreen> createState() =>
      _LinkWithCaregiverScreenState();
}

class _LinkWithCaregiverScreenState extends State<LinkWithCaregiverScreen> {
  TextEditingController relationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  FocusNode relationFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();

  late Dio dio;
  late DioClient dioClient;
  late PatientUserApi userApi;
  late PatientUserRepository patientUserRepository;

  SimpleFontelicoProgressDialog? prograssDialog;

  @override
  void initState() {
    super.initState();
    prograssDialog = SimpleFontelicoProgressDialog(context: context);
  }

  Future<void> showPrograssDialog() async {
    prograssDialog!
        .show(message: "جاري التحميل...", indicatorColor: AppColors.mintGreen);
  }

  Future<void> hidePrograssDialog() async {
    prograssDialog!.hide();
  }

  Future<String> imageLinkToBase64(String imageUrl) async {
    // Download the image bytes
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    // Encode the bytes as Base64
    final base64 = base64Encode(bytes);

    return base64;
  }

  @override
  Widget build(BuildContext context) {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          iconTheme: const IconThemeData(
            color: AppColors.mintGreen,
          ),
          centerTitle: true,
          title: const Text(
            'الربط مع مقدم رعاية',
            style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Image(
                    width: 300,
                    height: 300,
                    image:
                        AssetImage('assets/images/pictures/caregiverlink.png')),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: textField(
                      width: 300,
                      helperText: 'أدخل علاقتك او صلتك بمقدم الرعاية',
                      focusNode: bioFocusNode,
                      hintText: "ابن خالتي",
                      labelText: "العلاقة",
                      iconLead: Icons.family_restroom_outlined,
                      textFormController: bioController,
                      function: () {},
                      textType: TextInputType.text,
                      validatText: 'لا يمكن ترك هذا الحقل فارغ',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: textField(
                      width: 300,
                      helperText: 'أدخل أيميل مقدم الرعاية الخاص بك',
                      focusNode: emailFocusNode,
                      hintText: "example@gmail.com",
                      labelText: "البريد الالكتروني",
                      textFormController: emailController,
                      iconLead: Icons.email_rounded,
                      function: () {},
                      textType: TextInputType.emailAddress,
                      validatText: 'لا يمكن ترك هذا الحقل فارغ',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: filledIconButton(
                        width: 300,
                        height: 50,
                        buttonText: 'تنفيذ عملية الربط',
                        buttonIcon: Icons.link,
                        buttonColor: AppColors.mintGreen,
                        function: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.currentState!.validate()) {
                            try {
                              showPrograssDialog();
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? userToken =
                                  prefs.getString('currentUserToken');

                              await patientUserRepository
                                  .linkWithCaregiverRequest(
                                      bioController.value.text,
                                      "close",
                                      emailController.value.text,
                                      userToken!);

                              List userCaregivers = await patientUserRepository
                                  .getPatientCaregiversRequest(userToken);

                              int userId = userCaregivers[0]['user_id'];
                              log(userId.toString());
                              log(userCaregivers.toString());

                              String name =
                                  userCaregivers[0]['full_name'].toString();
                              String bio = userCaregivers[0]['bio'].toString();
                              String photo =
                                  userCaregivers[0]['photo_path'].toString();

                              String convertedPhoto =
                                  await imageLinkToBase64(photo);

                              await patientUserRepository
                                  .postUserNewFaceRequest(
                                      name, bio, convertedPhoto, userToken);

                              hidePrograssDialog();

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            } catch (e) {
                              hidePrograssDialog();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        'حدث خطأ غير متوقع يرجي إعادة المحاولة')),
                              );
                            }
                          } else {
                            hidePrograssDialog();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'حدث خطأ غير متوقع يرجي إعادة المحاولة')),
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
