import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:memory_mate/views/profile/profile_screen.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../components/buttons.dart';
import '../../constants/color_constatnts.dart';
import '../../networking/dio/api/dio_client.dart';
import '../../networking/dio/models api/patient_user_api.dart';
import '../../networking/dio/repositories/patient_user_repsitory.dart';

// ignore: must_be_immutable
class UpdateProfileScreen extends StatefulWidget {
  String userName;
  String imageLink;
  String address;
  String age;
  String phone;
  String email;
  String type;

  UpdateProfileScreen(
      {required this.userName,
      required this.address,
      required this.phone,
      required this.type,
      required this.age,
      required this.email,
      required this.imageLink,
      super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late Dio dio;
  late DioClient dioClient;
  late PatientUserApi userApi;
  late PatientUserRepository patientUserRepository;

  File? avatarImageFile;
  String? image;

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
        avatarImageFile = image;
      });
    }
    if (image == null) {
      Fluttertoast.showToast(
          msg: 'لم يتم اختيار صورة !', backgroundColor: AppColors.mintGreen);
    } else {}
  }

  Future<String> imageToBase64(dynamic image) async {
    if (image is File) {
      List<int> imageBytes = await image.readAsBytes();
      return base64Encode(imageBytes);
    } else if (image is String && image.startsWith('http')) {
      final response = await http.get(Uri.parse(image));
      final bytes = response.bodyBytes;
      return base64Encode(bytes);
    } else {
      throw ArgumentError(
          'Invalid argument: image must be a File or a network image URL');
    }
  }

  Future updateUserInformation(String avatar) async {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('currentUserToken');
    await patientUserRepository.updatePatientUserAvatarRequest(
        userToken!, "data:image/jpeg;base64,$avatar");
    await patientUserRepository.updatePatientUserRequest(
        userToken,
        userNameController.value.text,
        phoneController.value.text,
        emailController.value.text,
        addressController.value.text);
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
    userNameController.text = widget.userName;
    ageController.text = '${widget.age} عام';
    phoneController.text = widget.phone;
    addressController.text = widget.address;
    typeController.text = widget.type;
    emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mintGreen,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                    'تعديل الملف الشخصي',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 85, 0, 0),
                    alignment: Alignment.center,
                    child: avatarImageFile == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              widget.imageLink,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              avatarImageFile!,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),
                          )),
                Positioned(
                  top: 185,
                  right: 115,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.mintGreen,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          50,
                        ),
                      ),
                      color: AppColors.white,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      color: AppColors.mintGreen,
                      onPressed: () {
                        getImage();
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        topRight: Radius.circular(60.0))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340,
                          child: TextFormField(
                            controller: userNameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "الاسم بالكامل",
                              hintText: 'سهيل امجد فاضل',
                              hintStyle: TextStyle(
                                color: AppColors.lightmintGreen,
                              ),
                              prefixIcon: Icon(
                                Icons.person_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340.0,
                          child: TextFormField(
                            enabled: false,
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "العمر",
                              hintText: ' 39 عاما ',
                              hintStyle:
                                  TextStyle(color: AppColors.lightmintGreen),
                              prefixIcon: Icon(
                                Icons.calendar_month_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340.0,
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.ltr,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "الهاتف",
                              hintText: '01553734744 ',
                              hintStyle:
                                  TextStyle(color: AppColors.lightmintGreen),
                              prefixIcon: Icon(
                                Icons.phone_iphone_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 249, 249, 249),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340.0,
                          child: TextFormField(
                            controller: addressController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "العنوان",
                              hintText: '  شارع الرحاب وسط البلد  ',
                              hintStyle:
                                  TextStyle(color: AppColors.lightmintGreen),
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 249, 249, 249),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340.0,
                          child: TextFormField(
                            enabled: false,
                            controller: typeController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: ' الفئة ',
                              hintText: "مريض",
                              hintStyle:
                                  TextStyle(color: AppColors.lightmintGreen),
                              prefixIcon: Icon(
                                Icons.merge_type,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340.0,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: ' البريد الالكتروني ',
                              hintText: "Sohailamged@gmail.com",
                              hintStyle:
                                  TextStyle(color: AppColors.lightmintGreen),
                              prefixIcon: Icon(
                                Icons.email_rounded,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      filledButton(
                        width: 340,
                        height: 50,
                        textSize: 20,
                        buttonText: 'تحديث البيانات',
                        function: () async {
                          await showPrograssDialog();
                          if (avatarImageFile == null) {
                            image = await imageToBase64(widget.imageLink);
                          } else {
                            image = await imageToBase64(avatarImageFile);
                          }

                          await updateUserInformation(image!);
                          await hidePrograssDialog();

                          // ignore: use_build_context_synchronously
                          AwesomeDialog(
                            context: context,
                            btnOkColor: AppColors.mintGreen,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'تم التحديث بنجاح',
                            btnOkOnPress: () {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const ProfileScreen(),
                                ),
                              );
                            },
                            btnOkText: "ًحسنا",
                          ).show();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
