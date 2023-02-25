import 'package:flutter/material.dart';

import '../../components/buttons.dart';
import '../../components/text_fields.dart';
import '../../constants/color_constatnts.dart';


class password extends StatefulWidget {
  const password({super.key});

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
  var passwordcontroller = TextEditingController();
  var confirmcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 40, 18, 25),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 250,
                  child: const Image(
                      image: AssetImage('assets/images/pictures/sign_up.jpeg')),
                ),
                Container(
                  child: textField(
                      isPassword: true,
                      function: () {},
                      hintText: 'الرقم السري ',
                      labelText: 'الرقم السري',
                      textType: TextInputType.visiblePassword,
                      iconLead: Icons.lock,
                      textFormController: passwordcontroller,
                      validatText: 'لا يمكن ان يكون فارغا'                   
                      ),
                ),
                Container(
                  child: textField(
                      isPassword: true,
                      function: () {},
                      textFormController: confirmcontroller,
                      hintText: 'تاكيد الرقم السري ',
                      labelText: 'تاكيد الرقم السري',
                      iconLead: Icons.lock,
                      validatText:  'لا يمكن ان يكون فارغا',
                      validatText2: 'كلمه السر غير متطابقه'                     ),
                ),
                Center(
                  child: Container(
                    child: filledButton(
                        buttonText: 'التالي',
                        buttonColor: AppColors.mintGreen,
                        function: () {
                          if (formKey.currentState!.validate()) {}
                        }),
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
