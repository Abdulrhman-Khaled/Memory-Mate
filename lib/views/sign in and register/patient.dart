import 'package:flutter/material.dart';
import 'package:memory_mate/views/sign%20in%20and%20register/pass.dart';

import '../../components/buttons.dart';
import '../../components/text_fields.dart';
import '../../constants/color_constatnts.dart';


class patiant extends StatefulWidget {
  const patiant({super.key});

  @override
  State<patiant> createState() => _patiantState();
}

class _patiantState extends State<patiant> {
  var addresscontroller = TextEditingController();
  var dobcontroller = TextEditingController();
  var jobcontroller = TextEditingController();
  var healthcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 40.0, 18, 20),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  child: const Image(
                      image: AssetImage('assets/images/pictures/sign_up.jpeg')),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: Container(
                    child: textField(
                      labelText: 'العنوان',
                      hintText: 'العنوان',
                      iconLead: Icons.location_on,
                      textFormController: addresscontroller,
                      textType: TextInputType.streetAddress,
                      function: () {},
                      validatText: 'لا يمكن ان يكون فارغا'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: Container(
                    child: textField(
                      labelText: 'تاريخ الميلاد ',
                      hintText: 'dd/mm/yy',
                      iconLead: Icons.calendar_month,
                      textFormController: dobcontroller,
                      textType: TextInputType.datetime,
                      function: () {},
                      validatText: 'لا يمكن ان يكون فارغا'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: Container(
                    child: textField(
                      labelText: 'الوظيفة ',
                      hintText: 'الوظيفه ',
                      iconLead: Icons.work_rounded,
                      textFormController: jobcontroller,
                      function: () {},
                      validatText: 'لا يمكن ان يكون فارغا'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: Container(
                    child: textField(
                      labelText: 'مرحله المرض ',
                      hintText: 'مرحله المرض  ',
                      iconLead: Icons.health_and_safety,
                      textFormController: healthcontroller,
                      function: () {},
                      validatText: 'لا يمكن ان يكون فارغا'
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    child: filledButton(
                        buttonText: 'التالي',
                        buttonColor: AppColors.mintGreen,
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => password()));
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
