import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/buttons.dart';
import '../../constants/color_constatnts.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int secondsRemaining = 30;
  bool enableOnTap = true;
  late Timer _timer;
  int _start = 30;
  bool isVisiable = false;
  Color sendAgain = AppColors.lightBlack;

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
            'تفعيل الحساب',
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
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      });
                },
              ),
              const SizedBox(
                height: 40,
              ),
              filledButton(
                width: 300,
                height: 50,
                function: () {},
                buttonColor: AppColors.white,
                buttonText: 'تفعيل',
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
                        ? () {
                            startTimer();
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
