import 'package:flutter/material.dart';
import 'package:memory_mate/views/sign%20in%20and%20register/sign%20up%20and%20register/sign_up_continue_screen.dart';

import 'package:page_transition/page_transition.dart';

import '../../../components/buttons.dart';
import '../../../components/text_fields.dart';
import '../../../constants/color_constatnts.dart';


enum SingingCharacter { patient, caregiver }

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  SingingCharacter? _character = SingingCharacter.patient;
  late bool isChecked = true;

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
          'إنشاء حساب جديد',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Image(
                  image: AssetImage('assets/images/pictures/sign_up.jpeg')),
              Align(
                alignment: Alignment.center,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: textField(
                    helperText: 'أدخل اسمك بالكامل لنقوم بالتعرف عليك',
                    focusNode: nameFocusNode,
                    width: 300,
                    hintText: "اسم المستخدم",
                    labelText: "اسم المستخدم",
                    iconLead: Icons.person_outlined,
                    textFormController: namecontroller,
                    function: () {},
                    textType: TextInputType.name,
                    validatText: 'لا يمكن ترك هذا الحقل فارغ',
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                    textFormController: phonecontroller,
                    function: () {},
                    needMax: true,
                    maxLetters: 11,
                    textType: TextInputType.phone,
                    validatText: 'لا يمكن ترك هذا الحقل فارغ',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: textField(
                    width: 300,
                    helperText: 'أدخل أيميلك الحالي',
                    focusNode: emailFocusNode,
                    hintText: "example@gmail.com",
                    labelText: "البريد الالكتروني",
                    textFormController: emailcontroller,
                    iconLead: Icons.email_rounded,
                    function: () {},
                    textType: TextInputType.emailAddress,
                    validatText: 'لا يمكن ترك هذا الحقل فارغ',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(right: 50),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.merge_type_outlined,
                        color: AppColors.mintGreen,
                        size: 30,
                      ),
                      Text(
                        'إنشاء حساب لشخص',
                        style: TextStyle(
                          color: AppColors.mintGreen,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 40),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    minLeadingWidth: 35,
                    title: const Text(
                      'مريض',
                      style: TextStyle(
                        color: AppColors.lightBlack,
                        fontSize: 20,
                      ),
                    ),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.patient,
                      groupValue: _character,
                      onChanged: (SingingCharacter? checkValue) {
                        setState(() {
                          _character = checkValue;
                          isChecked = true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 40),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    minLeadingWidth: 35,
                    title: const Text(
                      'مقدم رعاية',
                      style: TextStyle(
                        color: AppColors.lightBlack,
                        fontSize: 20,
                      ),
                    ),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.caregiver,
                      groupValue: _character,
                      onChanged: (SingingCharacter? checkValue) {
                        setState(() {
                          _character = checkValue;
                          isChecked = false;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: filledButton(
                    width: 300,
                    height: 50,
                    buttonText: 'التالي',
                    buttonColor: AppColors.mintGreen,
                    function: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState!.validate()) {
                        isChecked
                            ? Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const SignUpData(
                                      'إنشاء حساب لمريض',
                                    )),
                              )
                            : Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const SignUpData(
                                        'إنشاء حساب لمقدم رعاية')),
                              );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  'حدث خطأ غير متوقع يرجي إعادة المحاولة')),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
