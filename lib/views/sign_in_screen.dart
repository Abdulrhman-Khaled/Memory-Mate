import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/components/buttons.dart';
import 'package:memory_mate/constants/color_constatnts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Image(
                image: AssetImage(
                    'assets/images/pictures/sign_in_illistration.png'),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.fromLTRB(40.0, 0, 30.0, 0),
              child: Text(
                'قم بإنشاء حساب جديد من هنا لتبدأ رحلتك',
                style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            filledButton(
              width: 300,
              height: 50,
              buttonText: 'إنشاء حساب جديد',
              function: () {
                if (kDebugMode) {
                  print('object');
                }
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'لديك حساب بالفعل؟',
              style: TextStyle(fontSize: 20, color: AppColors.mintGreen),
            ),
            const SizedBox(height: 20),
            outlineButton(
                width: 300,
                height: 50,
                buttonText: 'تسجيل الدخول',
                function: () {
                  if (kDebugMode) {
                    print('object');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
