import 'package:flutter/material.dart';
import 'package:memory_mate/components/buttons.dart';
import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:memory_mate/views/sign in and register/sign_in_screen.dart';
import 'package:memory_mate/views/sign%20in%20and%20register/sign_up_screen.dart';
import 'package:page_transition/page_transition.dart';

class SignInOrRegister extends StatefulWidget {
  const SignInOrRegister({super.key});

  @override
  State<SignInOrRegister> createState() => _SignInOrRegisterState();
}

class _SignInOrRegisterState extends State<SignInOrRegister> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: 
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Image(
                image: AssetImage(
                    'assets/images/pictures/sign_in_or_register_illistration.png'),
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
               Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: const SignUp()),
                  );
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
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: const SignIn()),
                  );
                }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
