import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/components/buttons.dart';
import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../networking/dio/api/dio_client.dart';
import '../../networking/dio/models api/patient_user_api.dart';
import '../../networking/dio/repositories/patient_user_repsitory.dart';

class PreviewAndDetectionScreen extends StatefulWidget {
  final File imageFile;

  const PreviewAndDetectionScreen({
    super.key,
    required this.imageFile,
  });

  @override
  State<PreviewAndDetectionScreen> createState() =>
      _PreviewAndDetectionScreenState();
}

class _PreviewAndDetectionScreenState extends State<PreviewAndDetectionScreen> {
  late Dio dio;

  late DioClient dioClient;

  late PatientUserApi userApi;

  late PatientUserRepository patientUserRepository;

  bool isLoading = true;

  Future<String> fileToBase64(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();
    final base64 = base64Encode(bytes);
    return base64;
  }

  Map<String, dynamic> resultMap = {};

  List<dynamic> careGiversList = [];

  SimpleFontelicoProgressDialog? prograssDialog;

  @override
  void initState() {
    super.initState();
    getUserFaces();
    prograssDialog = SimpleFontelicoProgressDialog(context: context);
  }

  Future<void> showPrograssDialog() async {
    prograssDialog!
        .show(message: "جاري التحميل...", indicatorColor: AppColors.mintGreen);
  }

  Future<void> hidePrograssDialog() async {
    prograssDialog!.hide();
  }

  Future<void> getUserFaces() async {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('currentUserToken');
    List<dynamic> userAllFaces =
        await patientUserRepository.getUserAllFaces(userToken!);

    log(userAllFaces.toString());
    setState(() {
      careGiversList = userAllFaces;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: AppColors.mintGreen,
        ),
        centerTitle: true,
        title: const Text(
          'عرض الصورة',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.mintGreen,
              backgroundColor: AppColors.white,
            ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.file(
                  widget.imageFile,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 200,
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: filledIconButton(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          buttonText: 'تحديد\nالشخص',
                          buttonColor: AppColors.mintGreen,
                          iconSize: 40,
                          buttonIcon: Icons.person_search_outlined,
                          function: () async {
                            String face =
                                await fileToBase64(widget.imageFile.path);
                            showPrograssDialog();
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? userToken =
                                prefs.getString('currentUserToken');

                            Map<String, dynamic> result =
                                await patientUserRepository
                                    .postFaceToDetectRequest(face, userToken!);

                            setState(() {
                              resultMap = result;
                            });

                            List<dynamic> filteredList = careGiversList
                                .where(
                                    (map) => map.containsValue(result['Name']))
                                .toList();

                            String detectName = filteredList[0]['name'];
                            String detectBio = filteredList[0]['bio'];
                            String detectImageLink = filteredList[0]['face_url'];

                            // ignore: use_build_context_synchronously
                            await showDialog(
                                context: context,
                                builder: result['Name'] == 'Unknown'
                                    ? (context) {
                                        return const MyDialog(
                                          name: 'شخص غير معروف',
                                          bio:
                                              'لا يوجد بينك وبينه اي علاقة مسجلة',
                                          text:
                                              'توخي الحذر لم يتم التعرف علي هذا الشخص من ضمن قائمة العائلة والاصدقاء',
                                          imageLink:
                                              'https://icon-library.com/images/unknown-person-icon/unknown-person-icon-20.jpg',
                                        );
                                      }
                                    : (context) {
                                        return MyDialog(
                                            name: detectName,
                                            bio: detectBio,
                                            text:
                                                'تم التعرف علي هذا الشخص بنجاح الا تتذكره؟؟',
                                            imageLink: detectImageLink);
                                      });

                            log(result.toString());
                          })),
                ),
              ],
            ),
    );
  }
}

class MyDialog extends StatelessWidget {
  final String name;
  final String bio;
  final String text;
  final String imageLink;

  const MyDialog({super.key, 
    required this.name,
    required this.bio,
    required this.text,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("تحديد الشخص"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(imageLink),
          const SizedBox(height: 16),
          const Text("", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text(text),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('حسناً'),
        ),
      ],
    );
  }
}
