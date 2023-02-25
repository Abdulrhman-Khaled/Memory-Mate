import 'package:flutter/material.dart';
import 'package:memory_mate/views/sign%20in%20and%20register/pass.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/buttons.dart';
import '../../components/text_fields.dart';
import '../../constants/color_constatnts.dart';


class CareGiver extends StatefulWidget {
  const CareGiver({super.key});

  @override
  State<CareGiver> createState() => _CareGiverState();
}

class _CareGiverState extends State<CareGiver> {
  var addresscontroller = TextEditingController();
  var dobcontroller = TextEditingController();
  var relationcontroller = TextEditingController();
  var idcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                child:
                    const Image(image: AssetImage('assets/images/pictures/sign_up.jpeg')),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                child: Container(
                  child: textField(
                    labelText: 'تاريخ الميلاد',
                    hintText: 'dd/mm/yy',
                    iconLead: Icons.calendar_month,
                    textFormController: dobcontroller,
                    function: () {},
                    textType: TextInputType.datetime,
                    validatText: 'لا يمكن ان يكون فارغا'
                    ,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                child: Container(
                  child: textField(
                    labelText: 'العنوان',
                    hintText: 'العنوان',
                    iconLead: Icons.location_on,
                    textFormController: addresscontroller,
                    function: () {},
                    textType: TextInputType.streetAddress,
                    validatText:'لا يمكن ان يكون فارغا'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                child: Container(
                  child: textField(
                    labelText: 'صله قرابته بالمريض',
                    hintText: 'صله القرابه',
                    iconLead: Icons.group,
                    textFormController: relationcontroller,
                    function: () {},
                    validatText: 'لا يمكن ان يكون فارغا'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                child: Container(
                  child: textField(
                      labelText: 'الرقم التعريفي للمريض ',
                      hintText: 'الرقم التعريفي ',
                      iconLead: Icons.numbers,
                      textFormController: idcontroller,
                      function: () {},
                      validatText: 'لا يمكن ان يكون فارغا',
                      textType: TextInputType.number),
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
                            PageTransition(
                        type: PageTransitionType.fade, child: const password()),);
                        print(addresscontroller.text);
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
