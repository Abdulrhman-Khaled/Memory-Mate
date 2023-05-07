import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/components/buttons.dart';
import 'package:memory_mate/components/text_fields.dart';
import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:memory_mate/networking/dio/repositories/patient_user_repsitory.dart';
import 'package:memory_mate/views/home%20pages/caregiver_home_screen.dart';
import 'package:memory_mate/views/sign%20in%20and%20register/sign%20up%20and%20register/sign_up_screen.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../../networking/dio/api/dio_client.dart';
import '../../../networking/dio/models api/patient_user_api.dart';
import '../../../networking/dio/repositories/authantication.dart';
import '../../home pages/patient_home_screen.dart';
import '../forget password/forget_password_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late Dio dio;
  late DioClient dioClient;
  late PatientUserApi userApi;
  late AuthRepository authRepository;
  late PatientUserRepository patientUserRepository;

  SimpleFontelicoProgressDialog? prograssDialog;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  bool obscured = false;

  @override
  void initState() {
    super.initState();
    prograssDialog = SimpleFontelicoProgressDialog(context: context);
    obscured = true;
  }

  Future<void> showPrograssDialog() async {
    prograssDialog!
        .show(message: "جاري التحميل...", indicatorColor: AppColors.mintGreen);
  }

  Future<void> hidePrograssDialog() async {
    prograssDialog!.hide();
  }

  erorrBuilder(String erorrMesseage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red, content: Text(erorrMesseage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    authRepository = AuthRepository(userApi);
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
          'تسجيل الدخول',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage(
                      'assets/images/pictures/sign_in_illistration.png'),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                    width: 300,
                    labelText: 'الإيميل',
                    helperText: 'أدخل الإيميل الذي قمت بانشاء حسابك من خلاله',
                    iconLead: Icons.email_outlined,
                    hintText: 'example@gmail.com',
                    textType: TextInputType.emailAddress,
                    textFormController: emailController,
                    focusNode: emailFocusNode,
                    validatText: 'يرجي ادخال إيميل صالح'),
              ),
              const SizedBox(height: 25),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                  width: 300,
                  labelText: 'كلمة المرور',
                  helperText:
                      'أدخل كلمة المرور التي قمت بتعينها عند انشاء حسابك',
                  iconLead: Icons.lock_outline,
                  hintText: '•••••••••••••••••',
                  textType: TextInputType.visiblePassword,
                  textFormController: passwordController,
                  focusNode: passwordFocusNode,
                  validatText: 'يرجي ادخال كلمة مرور صحيحة',
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
              const SizedBox(height: 5),
              Container(
                width: 300,
                alignment: AlignmentDirectional.topStart,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: const ForgetPasswordScreen()),
                    );
                  },
                  child: const Text(
                    'نسيت كلمة المرور',
                    style: TextStyle(
                        color: AppColors.mintGreen,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              filledButton(
                width: 300,
                height: 50,
                buttonText: 'تسجيل الدخول',
                function: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (formKey.currentState!.validate()) {
                    try {
                      showPrograssDialog();
                      Response response = await authRepository.login(
                          emailController.value.text,
                          passwordController.value.text);
                      String userToken = response.data['token'];
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('currentUserToken', userToken);
                      Map<String, dynamic> userTypeGetter =
                          await patientUserRepository
                              .getPatientUserRequest(userToken);
                      String type = await userTypeGetter['userType'];
                      await prefs.setString('currentUserType', type);
                      hidePrograssDialog();
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: type == 'PATIENT' ? const PatientHomeScreen() : const CareGiverHomeScreen()),
                          (Route<dynamic> route) => false);
                    } catch (e) {
                      log(e.toString());
                      hidePrograssDialog();
                      erorrBuilder('خطأ في البيانات يرجي إعادة المحاولة');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.red,
                          content:
                              Text('حدث خطأ غير متوقع يرجي إعادة المحاولة')),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: const SignUp()),
                      );
                    },
                    child: const Text(
                      'انشاء حساب الأن',
                      style: TextStyle(
                          color: AppColors.mintGreen,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'ليس لديك حساب بعد؟',
                    style: TextStyle(fontSize: 15, color: AppColors.lightBlack),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
