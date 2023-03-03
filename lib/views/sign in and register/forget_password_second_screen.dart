import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/buttons.dart';
import '../../components/text_fields.dart';
import '../../constants/color_constatnts.dart';





// ignore: camel_case_types
class forgetTwo extends StatelessWidget {
  const forgetTwo ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              Image(
              width : 260.0,
              height: 260.0,
              image: 
                AssetImage(
                    'assets/images/pictures/pass.png'),
              ),
              //const SizedBox(height: 10),
              Text(
                "  أدخل كلمة المرورالجديدة",
                style: TextStyle(fontSize: 22, color: AppColors.mintGreen,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "كلمة المرور الجديدة يجب ان تكون مختلفة عن كلمة المرور المستخدمة من قبل",
                  style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 175, 175, 175)),
                  textAlign: TextAlign.center,
                ),
              ),
              
                SizedBox(
                  height: 10.0,
                ),
                textField(
                  fillColor: Color.fromARGB(255, 245, 245, 245),
                  width: 300.0,
                  height: 90.0, 
                  labelText: 'كلمة المرور' ,
                  labelSize: 14.0,
                  hintText: '...',
                  isPassword: true,
                  textType: TextInputType.number,
                  iconLead: Icons.lock_open_rounded,
                  iconSize: 20.0,
                  
                ),
                
                textField(
                  fillColor: Color.fromARGB(255, 245, 245, 245),
                  width: 300.0,
                  height: 90.0,
                  labelText: 'تأكيد كلمة المرور' ,
                  labelSize: 14.0,
                  hintText: '...',
                  isPassword: true,
                  textType: TextInputType.number,
                  iconLead: Icons.lock_outline_rounded,
                  iconSize: 20.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                filledButton(
                  width: 300,
                  height: 50,
                  buttonText: 'تحديث',
                  function: () {
                    if (kDebugMode) {
                      print('object');
                    }
                  },
                ),
            ]
          ),
        ),
      ),
   
   );
     
    
  }
}