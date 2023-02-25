import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/buttons.dart';
import '../../components/text_fields.dart';

class forgetOne extends StatelessWidget {
  forgetOne({Key? key}) : super(key: key);

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60.0),
              alignment: Alignment.topCenter,
              //transformAlignment: T,
              child: Image.asset(
                'assets/images/pictures/phone.png',
                height: 120.0,
                width: 120.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'أدخل رقم الهاتف',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(33, 159, 148, .8),
                  fontWeight: FontWeight.w700,
                  fontSize: 25),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'سنقوم بارسال الكود الخاص بتغيير الرقم السري علي رقم هاتفك',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, color: Color.fromARGB(255, 175, 175, 175)),
            ),
            const SizedBox(height: 30),
            textField(
              fillColor: Color.fromARGB(255, 245, 245, 245),
              width: 300.0,
              height: 90.0,
              labelText: 'رقم الهاتف',
              labelSize: 14.0,
              hintText: '...',
              textType: TextInputType.phone,
              iconLead: Icons.phone,
              iconSize: 20.0,
            ),
            const SizedBox(height: 10),
            filledButton(
              width: 300,
              height: 50,
              buttonText: 'إستعادة كلمة المرور',
              function: () {
                if (kDebugMode) {
                  print('object');
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
