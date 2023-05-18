// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../../networking/dio/api/dio_client.dart';
import '../../networking/dio/models api/patient_user_api.dart';
import '../../networking/dio/repositories/patient_user_repsitory.dart';
import '../../components/buttons.dart';
import '../../constants/color_constatnts.dart';

// ignore: camel_case_types
class raysDetect extends StatefulWidget {
  const raysDetect({super.key});

  @override
  State<raysDetect> createState() => _raysDetectState();
}

// ignore: camel_case_types
class _raysDetectState extends State<raysDetect> {
  late Dio dio;

  late DioClient dioClient;

  late PatientUserRepository patientUserRepository;

  late PatientUserApi userApi;

  File? rayImageFile;

  String? rayImage64;

  late String tempRayImage64;

  SimpleFontelicoProgressDialog? prograssDialog;

  getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery, imageQuality: 25)
        .catchError((onError) {
      // ignore: invalid_return_type_for_catch_error
      return Fluttertoast.showToast(msg: onError.toString());
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      setState(() {
        rayImageFile = image;
        Image.file(image!);
      });
    }
    if (image == null) {
      Fluttertoast.showToast(
          msg: 'لم يتم اختيار صورة !',
          textColor: AppColors.mintGreen,
          backgroundColor: AppColors.white);
    }
  }

  Future<String> fileToBase64(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();
    final base64 = base64Encode(bytes);
    return base64;
  }

  Future<void> showPrograssDialog() async {
    prograssDialog!
        .show(message: "جاري التحميل...", indicatorColor: AppColors.mintGreen);
  }

  Future<void> hidePrograssDialog() async {
    prograssDialog!.hide();
  }

  @override
  void initState() {
    super.initState();
    prograssDialog = SimpleFontelicoProgressDialog(context: context);
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
          'اختبار الاشعة',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: rayImageFile == null
                ? Image.asset(
                    'assets/images/pictures/ray_detection.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 200,
                  )
                : Image.file(
                    rayImageFile!,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 200,
                  ),
            onTap: () {
              getImage();
              setState(() {});
            },
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: filledIconButton(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    buttonText: 'فحص الاشعة',
                    buttonColor: AppColors.mintGreen,
                    iconSize: 40,
                    buttonIcon: Icons.person_search_outlined,
                    function: () async {
                      String ray = await fileToBase64(rayImageFile!.path);
                      showPrograssDialog();
                      if (rayImageFile == null) {
                        Fluttertoast.showToast(
                            msg: 'لم يتم اختيار صورة !',
                            textColor: AppColors.mintGreen,
                            backgroundColor: AppColors.white);
                        await hidePrograssDialog();
                      }

                      Response result = await patientUserRepository
                          .postXRayToDetectRequest(ray);

                      String className = result.data['Class'];
                      String probability = result.data['probability'];
                      String onlyProbability = probability.split(' ')[0];

                      await showDialog(
                          context: context,
                          builder: className == 'Non Demented'
                              ? (context) {
                                  return const MyDialog(
                                    result: 'الحالة لاتعاني من مرض الزهايمر',
                                    ratio: '0.00 %',
                                  );
                                }
                              : (context) {
                                  return MyDialog(
                                    result: 'الحالة تعاني من مرض الزهايمر',
                                    ratio: onlyProbability,
                                  );
                                });
                      hidePrograssDialog();
                    })),
          ),
        ],
      ),
    );
  }
}

class MyDialog extends StatelessWidget {
  final String result;
  final String ratio;

  const MyDialog({
    super.key,
    required this.result,
    required this.ratio,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
          child: Text("حالة الاشعة ",
              style: TextStyle(fontSize: 22, color: AppColors.mintGreen))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Directionality(
              textDirection: TextDirection.rtl,
              child: Text('حالة المريض : ', style: TextStyle(fontSize: 20))),
          Text(result,
              style: const TextStyle(
                  fontSize: 22,
                  color: AppColors.mintGreen,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Directionality(
            textDirection: TextDirection.rtl,
            child: Text('احتمالية الأصابة بالزهايمر : ',
                style: TextStyle(fontSize: 20)),
          ),
          Text(ratio,
              style: const TextStyle(
                  fontSize: 22,
                  color: AppColors.mintGreen,
                  fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Center(
            child: Text('حسناً',
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.mintGreen,
                )),
          ),
        ),
      ],
    );
  }
}
