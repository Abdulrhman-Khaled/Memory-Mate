import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:page_transition/page_transition.dart';

import '../../../components/buttons.dart';
import '../../../components/text_fields.dart';
import '../../../constants/color_constatnts.dart';
import 'creat_new_password_screen.dart';

class SignUpAsPatiant extends StatefulWidget {
  const SignUpAsPatiant({super.key});

  @override
  State<SignUpAsPatiant> createState() => _SignUpAsPatiantState();
}

class _SignUpAsPatiantState extends State<SignUpAsPatiant> {


  var addressController = TextEditingController();
  var dobController = TextEditingController();
  var jobController = TextEditingController();
  var healthController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final addressFocusNode = FocusNode();
  final dobFocusNode = FocusNode();
  final jobFocusNode = FocusNode();
  final healthFocusNode = FocusNode();

  DateTime customDateOfBirth = DateTime(2001, 1, 1);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    log(arguments.toString());

    dobController.text =
        '${customDateOfBirth.year}/${customDateOfBirth.month}/${customDateOfBirth.day}';
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
          'إنشاء حساب لمريض',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                  image: AssetImage('assets/images/pictures/sign_up.jpeg')),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                  width: 300,
                  labelText: 'العنوان',
                  hintText: '65 شارع السلام, القاهرة',
                  helperText: 'أدخل عنوان سكنك الحالي',
                  focusNode: addressFocusNode,
                  iconLead: Icons.location_on,
                  textFormController: addressController,
                  textType: TextInputType.streetAddress,
                  function: () {},
                  validatText: 'لا يمكن ترك هذا الحقل فارغ',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                    width: 300,
                    readOnly: true,
                    labelText: 'تاريخ الميلاد ',
                    helperText: 'أدخل تاريخ يوم ميلادك',
                    hintText: 'العام/الشهر/اليوم',
                    onTapFunction: () async {
                      DateTime? newDateOfBirth = await showDatePicker(
                          context: context,
                          initialDate: customDateOfBirth,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (newDateOfBirth == null) return;
                      setState(() => customDateOfBirth = newDateOfBirth);
                    },
                    iconLead: Icons.calendar_month,
                    focusNode: dobFocusNode,
                    textFormController: dobController,
                    textType: TextInputType.datetime,
                    function: () {},
                    validatText: 'لا يمكن ترك هذا الحقل فارغ'),
              ),
              const SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                    width: 300,
                    labelText: 'الوظيفة',
                    hintText: 'الوظيفة',
                    helperText: 'أدخل وظيفتك الحالية',
                    focusNode: jobFocusNode,
                    iconLead: Icons.work_outline,
                    textFormController: jobController,
                    function: () {},
                    validatText: 'لا يمكن ترك هذا الحقل فارغ'),
              ),
              const SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                    width: 300,
                    labelText: 'مرحلة المرض',
                    hintText: 'مرحلة المرض',
                    helperText: 'أدخل مرحلتك في مرض الزهايمر',
                    iconLead: Icons.health_and_safety,
                    textFormController: healthController,
                    focusNode: healthFocusNode,
                    function: () {},
                    validatText: 'لا يمكن ترك هذا الحقل فارغ'),
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
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        PageTransition(
                            settings:RouteSettings(arguments:{
                              ...arguments,
                              "address":addressController.value.text,
                              "date_of_birth":customDateOfBirth.toString().substring(0,10)

                            }),
                            type: PageTransitionType.fade,
                            child: const CreatPasswordScreen()),
                      );
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
