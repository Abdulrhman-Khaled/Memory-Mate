import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:memory_mate/views/sign%20in%20and%20register/patient.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/buttons.dart';
import '../../components/text_fields.dart';
import '../../constants/color_constatnts.dart';
import 'CareGiver.dart';

enum SingingCharacter { patient, CareGiver }

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  SingingCharacter? _character = SingingCharacter.patient;
  late bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  child: const Image(
                      image: AssetImage('assets/images/pictures/sign_up.jpeg')),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: textField(
                    hintText: "اسم المستخدم",
                    labelText: "اسم المستخدم",
                    iconLead: Icons.account_circle_rounded,
                    textFormController: namecontroller,
                    function: () {},
                    textType: TextInputType.name,
                    validatText: 'لا يمكن ان يكون فارغا',
                  ),
                ),
                textField(
                    hintText: "رقم الهاتف",
                    labelText: "رقم الهاتف ",
                    iconLead: Icons.smartphone_rounded,
                    textFormController: phonecontroller,
                    function: () {},
                    textType: TextInputType.phone,
                    validatText: 'لا يمكن ان يكون فارغا'),
                textField(
                    hintText: "البريد الالكتروني ",
                    labelText: "البريد الالكتروني ",
                    textFormController: emailcontroller,
                    iconLead: Icons.email_rounded,
                    function: () {},
                    textType: TextInputType.emailAddress,
                    validatText: ''),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    'اختر فئه',
                    style: TextStyle(
                      color: AppColors.mintGreen,
                      fontSize: 25,
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('مريض '),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.patient,
                          groupValue: _character,
                          onChanged: (SingingCharacter? check_value) {
                            setState(() {
                              _character = check_value;
                              isChecked = true;
                              // print(check_value);
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('مقدم رعايه'),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.CareGiver,
                          groupValue: _character,
                          onChanged: (SingingCharacter? check_value) {
                            setState(() {
                              _character = check_value;
                              isChecked = false;
                              // print(check_value);
                            });
                          },
                        ),
                      ),
                      filledButton(
                          buttonText: 'التالي',
                          buttonColor: AppColors.mintGreen,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              isChecked
                                  ? Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: const patiant()),
                                    )
                                  : Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: const CareGiver()),
                                    );
                            }
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
