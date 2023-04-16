// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:memory_mate/views/sign%20in%20and%20register/forget%20password/set_new_password_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../../components/buttons.dart';
import '../../../constants/color_constatnts.dart';
import '../../../networking/dio/api/dio_client.dart';
import '../../../networking/dio/models api/patient_user_api.dart';
import '../../../networking/dio/repositories/patient_user_repsitory.dart';

// ignore: must_be_immutable
class OTPForgetPasswordScreen extends StatefulWidget {
  String email;
  String token;
  OTPForgetPasswordScreen({
    Key? key,
    required this.email,
    required this.token,
  }) : super(key: key);

  @override
  State<OTPForgetPasswordScreen> createState() =>
      _OTPForgetPasswordScreenState();
}

class _OTPForgetPasswordScreenState extends State<OTPForgetPasswordScreen> {
  late Dio dio;

  late DioClient dioClient;

  late PatientUserApi userApi;

  late PatientUserRepository patientUserRepository;

  String enteredCode = '';

  int secondsRemaining = 30;
  bool enableOnTap = true;
  final oneSec = const Duration(seconds: 1);
  late Timer _timer = Timer(oneSec, () {});
  int _start = 30;
  bool isVisiable = false;
  Color sendAgain = AppColors.lightBlack;

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

  void startTimer() {
    isVisiable = true;
    sendAgain = AppColors.darkGrey;
    enableOnTap = false;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            sendAgain = AppColors.lightBlack;
            isVisiable = false;
            enableOnTap = true;
            _start = 30;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.mintGreen,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.mintGreen,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: AppColors.mintGreen,
          iconTheme: const IconThemeData(
            color: AppColors.white,
          ),
          centerTitle: true,
          title: const Text(
            'إعادة تعيين كلمة المرور',
            style: TextStyle(fontSize: 25, color: AppColors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 270,
                child: const Image(
                  image: AssetImage('assets/images/pictures/otp.png'),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'أرسلنا لك كود عبر رسالة لهاتفك\nبرجاء ادخال الكود لاتمام عملية التفعيل',
                style: TextStyle(fontSize: 18, color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              OtpTextField(
                numberOfFields: 6,
                borderColor: AppColors.white,
                showFieldAsBox: true,
                filled: true,
                fieldWidth: 50,
                enabledBorderColor: AppColors.white,
                focusedBorderColor: const Color.fromARGB(255, 26, 106, 98),
                fillColor: AppColors.lightmintGreen,
                textStyle:
                    const TextStyle(fontSize: 20, color: AppColors.white),
                cursorColor: AppColors.white,
                onSubmit: (String verificationCode) {
                  setState(() {
                    enteredCode = verificationCode;
                  });
                },
              ),
              const SizedBox(
                height: 40,
              ),
              filledButton(
                width: 300,
                height: 50,
                function: () async {
                  try {
                    showPrograssDialog();

                    Response response = await patientUserRepository
                        .postVerifyOtpRequest(enteredCode, widget.token);
                    String userToken = await response.data['token'];
                    hidePrograssDialog();
                    if (userToken == widget.token) {
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: SetNewPasswordScreen(token: widget.token,)));
                    } else {
                      hidePrograssDialog();
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.red,
                          content:
                              Text('هناك خطأ في البيانات يرجي إعادة المحاولة')),
                    );
                    }
                  } catch (e) {
                    hidePrograssDialog();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.red,
                          content:
                              Text('هناك خطأ في البيانات يرجي إعادة المحاولة')),
                    );
                  }
                },
                buttonColor: AppColors.white,
                buttonText: 'تأكيد',
                buttonTextColor: AppColors.mintGreen,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: enableOnTap
                        ? () async {
                            startTimer();
                            showPrograssDialog();
                            await patientUserRepository.postOtpRequest(
                                widget.email, widget.token);
                            hidePrograssDialog();
                          }
                        : null,
                    child: Text(
                      'إعادة الأرسال',
                      style: TextStyle(
                          color: sendAgain,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'لم تصلك رسالة بعد؟',
                    style: TextStyle(fontSize: 18, color: AppColors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: isVisiable,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '00:$_start',
                      style:
                          const TextStyle(fontSize: 15, color: AppColors.white),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Text(
                      'إمكانية ارسال كود مرة اخري خلال',
                      style: TextStyle(fontSize: 15, color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
