import 'package:flutter/material.dart';
import 'package:memory_mate/views/sign%20in%20and%20register/creat_new_password_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/buttons.dart';
import '../../components/text_fields.dart';
import '../../constants/color_constatnts.dart';

class SignUpAsCaregiver extends StatefulWidget {
  const SignUpAsCaregiver({super.key});

  @override
  State<SignUpAsCaregiver> createState() => _SignUpAsCaregiverState();
}

class _SignUpAsCaregiverState extends State<SignUpAsCaregiver> {
  var addressController = TextEditingController();
  var dobController = TextEditingController();
  var relationController = TextEditingController();
  var idController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final addressFocusNode = FocusNode();
  final dobFocusNode = FocusNode();
  final relationFocusNode = FocusNode();
  final idFocusNode = FocusNode();

  DateTime customDateOfBirth = DateTime(2001, 1, 1);

  @override
  Widget build(BuildContext context) {
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
          'إنشاء حساب لمقدم رعاية',
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
                    iconLead: Icons.location_on,
                    textFormController: addressController,
                    focusNode: addressFocusNode,
                    function: () {},
                    textType: TextInputType.streetAddress,
                    validatText: 'لا يمكن ترك هذا الحقل فارغ'),
              ),
              const SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                  width: 300,
                  labelText: 'تاريخ الميلاد',
                  helperText: 'أدخل تاريخ يوم ميلادك',
                  hintText: 'العام/الشهر/اليوم',
                  readOnly: true,
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
                  textFormController: dobController,
                  function: () {},
                  textType: TextInputType.datetime,
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
                    labelText: 'صله قرابتك بالمريض',
                    hintText: "ابن خالة المريض",
                    helperText: 'أدخل صلتك التي تصلك بالمريض',
                    iconLead: Icons.group,
                    textFormController: relationController,
                    function: () {},
                    focusNode: relationFocusNode,
                    validatText: 'لا يمكن ترك هذا الحقل فارغ'),
              ),
              const SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                    width: 300,
                    labelText: 'الرقم التعريفي للمريض ',
                    hintText: '#000000',
                    helperText: 'أدخل الرقم التعريفي للربط مع المريض',
                    iconLead: Icons.numbers,
                    textFormController: idController,
                    function: () {},
                    focusNode: idFocusNode,
                    validatText: 'لا يمكن ترك هذا الحقل فارغ',
                    textType: TextInputType.number),
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
                            type: PageTransitionType.fade,
                            child: const CreatPassword()),
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
