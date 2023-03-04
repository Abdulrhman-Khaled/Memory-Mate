import 'package:flutter/material.dart';
import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/buttons.dart';
import '../../../components/text_fields.dart';
import 'otp_forget_password_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  final phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

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
              'أدخل رقم الهاتف',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mintGreen, fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'سنقوم بارسال الكود الخاص بتغيير الرقم السري علي رقم هاتفك',
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
                  helperText: 'أدخل رقم هاتفك الحالي',
                  focusNode: phoneFocusNode,
                  hintText: "01552629829",
                  labelText: "رقم الهاتف",
                  iconLead: Icons.smartphone_outlined,
                  textFormController: phoneController,
                  function: () {},
                  needMax: true,
                  maxLetters: 11,
                  textType: TextInputType.phone,
                  validatText: 'لا يمكن ترك هذا الحقل فارغ',
                ),
              ),
            ),
            const SizedBox(height: 20),
            filledButton(
              width: 300,
              height: 50,
              buttonText: 'إرسال الكود',
              function: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: const OTPForgetPasswordScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('حدث خطأ غير متوقع يرجي إعادة المحاولة')),
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
