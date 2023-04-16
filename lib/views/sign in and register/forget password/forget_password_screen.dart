import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../../components/buttons.dart';
import '../../../components/text_fields.dart';
import '../../../networking/dio/api/dio_client.dart';
import '../../../networking/dio/models api/patient_user_api.dart';
import '../../../networking/dio/repositories/authantication.dart';
import '../../../networking/dio/repositories/patient_user_repsitory.dart';
import 'otp_forget_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late Dio dio;

  late DioClient dioClient;

  late PatientUserApi userApi;

  late PatientUserRepository patientUserRepository;

  final emailController = TextEditingController();

  final emailFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

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
          'إعادة تعيين كلمة المرور',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/pictures/reset_pass.png',
                height: 250.0,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'أدخل الإيميل الخاص بك ',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mintGreen, fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'سنقوم بارسال الكود الخاص بتغيير الرقم السري علي رقم هاتفك المربوط بحسابك',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: AppColors.lightBlack),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                  width: 300,
                  helperText: 'أدخل الإيميل المربوط بحسابك',
                  focusNode: emailFocusNode,
                  hintText: "example@gmail.com",
                  labelText: "الإيميل",
                  iconLead: Icons.email_outlined,
                  textFormController: emailController,
                  function: () {},
                  textType: TextInputType.emailAddress,
                  validatText: 'لا يمكن ترك هذا الحقل فارغ',
                ),
              ),
            ),
            const SizedBox(height: 20),
            filledButton(
              width: 300,
              height: 50,
              buttonText: 'إرسال الكود',
              function: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                if (formKey.currentState!.validate()) {
                  try {
                    showPrograssDialog();
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? userToken = prefs.getString('currentUserToken');
                    await patientUserRepository.postOtpRequest(
                        emailController.value.text, userToken!);
                    hidePrograssDialog();
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: OTPForgetPasswordScreen(
                              email: emailController.value.text,
                              token: userToken,
                            )));
                    hidePrograssDialog();
                  } catch (e) {
                    hidePrograssDialog();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.red,
                          content:
                              Text('هناك خطأ في البيانات يرجي إعادة المحاولة')),
                    );
                  }
                } else {
                  hidePrograssDialog();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        backgroundColor: Colors.red,
                        content:
                            Text('هناك خطأ في البيانات يرجي إعادة المحاولة')),
                  );
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
