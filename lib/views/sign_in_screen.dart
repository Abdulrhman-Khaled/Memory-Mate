import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/components/buttons.dart';
import 'package:memory_mate/components/text_fields.dart';
import 'package:memory_mate/constants/color_constatnts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool obscured = false;

  @override
  void initState() {
    super.initState();
    //emailController.text = testEmail;
    //passwordController.text = testPassword;
    obscured = true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  labelText: 'الإيميل او رقم الهاتف',
                  helperText:
                      'أدخل الإيميل او الهاتف الذي قمت بانشاء حسابك من خلاله',
                  iconLead: Icons.email_outlined,
                  hintText: 'example@gmail.com',
                  textType: TextInputType.emailAddress,
                  textFormController: emailController,
                  focusNode: emailFocusNode,
                ),
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
                  onTap: () {},
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
                function: () {
                  if (kDebugMode) {
                    print('object');
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
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
