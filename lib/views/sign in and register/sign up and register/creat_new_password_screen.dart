import 'package:flutter/material.dart';
import 'package:memory_mate/views/home%20pages/patient_home_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/buttons.dart';
import '../../../components/text_fields.dart';
import '../../../constants/color_constatnts.dart';

class CreatPasswordScreen extends StatefulWidget {
  const CreatPasswordScreen({super.key});

  @override
  State<CreatPasswordScreen> createState() => _CreatPasswordScreenState();
}

class _CreatPasswordScreenState extends State<CreatPasswordScreen> {
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  final passwordFocusNode = FocusNode();
  final passwordConfirmFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  String validatText = 'لا يمكن ترك هذا الحقل فارغ';
  String notMatchValidatText = 'كلمة المرور غير متطابقة';

  bool obscured = false;
  bool obscured2 = false;

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
                  function: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (formKey.currentState!.validate() &&
                        passwordController.text ==
                            passwordConfirmController.text) {
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
