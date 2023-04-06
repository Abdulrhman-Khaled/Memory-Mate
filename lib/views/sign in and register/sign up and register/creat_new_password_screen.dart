import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memory_mate/views/home%20pages/patient_home_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/buttons.dart';
import '../../../components/text_fields.dart';
import '../../../constants/color_constatnts.dart';
import '../../../models/user.dart';
import '../../../networking/dio/api/dio_client.dart';
import '../../../networking/dio/models api/patient_user_api.dart';
import '../../../networking/dio/repositories/authantication.dart';

// ignore: must_be_immutable
class CreatPasswordScreen extends StatefulWidget {
  String name;
  String email;
  String phone;
  String type;
  String image;
  String date;
  String address;

  CreatPasswordScreen(
      {required this.name,
      required this.email,
      required this.phone,
      required this.type,
      required this.image,
      required this.date,
      required this.address,
      super.key});

  @override
  State<CreatPasswordScreen> createState() => _CreatPasswordScreenState();
}

class _CreatPasswordScreenState extends State<CreatPasswordScreen> {
  late Dio dio;
  late DioClient dioClient;
  late PatientUserApi userApi;
  late AuthRepository authRepository;

  String? avatarImage64;
  late String tempAvatarImage64;
  String tempAvatar = "assets/images/pictures/avatar.png";

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  final passwordFocusNode = FocusNode();
  final passwordConfirmFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  String validatText = 'لا يمكن ترك هذا الحقل فارغ';
  String notMatchValidatText = 'كلمة المرور غير متطابقة';

  bool obscured = false;
  bool obscured2 = false;

  Future<String> fileOrAssetToBase64(String path, bool isAsset) async {
    if (isAsset) {
      final ByteData assetByteData = await rootBundle.load(path);
      final Uint8List assetUint8List = assetByteData.buffer.asUint8List();
      final base64 = base64Encode(assetUint8List);
      return base64;
    } else {
      final file = File(path);
      final bytes = await file.readAsBytes();
      final base64 = base64Encode(bytes);
      return base64;
    }
  }

  void myAsyncFunction() async {
    if (widget.image == tempAvatar) {
      String temp =
          await fileOrAssetToBase64("assets/images/pictures/avatar.png", true);
      setState(() {
        tempAvatarImage64 = temp;
      });
    } else {
      String real = await fileOrAssetToBase64(widget.image, false);
      setState(() {
        tempAvatarImage64 = real;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    obscured = true;
    obscured2 = true;
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myAsyncFunction();
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    authRepository = AuthRepository(userApi);

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
          'إنشاء كلمة مرور',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                  image: AssetImage('assets/images/pictures/sign_up.jpeg')),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                  isMatch: true,
                  isLength: true,
                  width: 300,
                  hintText: '•••••••••••••••••',
                  labelText: 'كلمة المرور',
                  helperText: 'أدخل كلمة مرور للدخول الي حسابك',
                  textType: TextInputType.visiblePassword,
                  iconLead: Icons.lock_outlined,
                  textFormController: passwordController,
                  matchPassword: passwordConfirmController.text,
                  thisPasssword: passwordController.text,
                  focusNode: passwordFocusNode,
                  validatText: validatText,
                  needSuffix: true,
                  isPassword: obscured,
                  iconSuffix: obscured
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  function: () {
                    setState(() {
                      obscured = !obscured;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                  isMatch: true,
                  isLength: true,
                  width: 300,
                  textFormController: passwordConfirmController,
                  focusNode: passwordConfirmFocusNode,
                  hintText: '•••••••••••••••••',
                  labelText: 'تأكيد كلمة المرور',
                  helperText: 'أدخل كلمة المرور مرة اخري للتأكيد',
                  iconLead: Icons.lock_outline,
                  matchPassword: passwordController.text,
                  thisPasssword: passwordConfirmController.text,
                  validatText: validatText,
                  needSuffix: true,
                  isPassword: obscured2,
                  iconSuffix: obscured2
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  function: () {
                    setState(() {
                      obscured2 = !obscured2;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              filledButton(
                  width: 300,
                  height: 50,
                  buttonText: 'التالي',
                  buttonColor: AppColors.mintGreen,
                  function: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (formKey.currentState!.validate() &&
                        passwordController.value.text ==
                            passwordConfirmController.value.text) {
                      User user = User.fromJson({
                        "full_name": widget.name,
                        "email": widget.email,
                        "password": passwordController.value.text,
                        "user_type": widget.type,
                        "address": widget.address,
                        "phone": widget.phone,
                        "date_of_birth": widget.date,
                        "photo_path":
                            "data:image/jpeg;base64,$tempAvatarImage64",
                      });
                      log(user.toJson().toString());
                      await authRepository.register(user);
                      //log(res.toString());

                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const PatientHomeScreen()),
                          (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                'هناك خطأ في البيانات يرجي إعادة المحاولة')),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
