import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/buttons.dart';
import '../../constants/color_constatnts.dart';

import 'add_field.dart';

import 'medical_appointment.dart';

class createAppointment extends StatefulWidget {
  const createAppointment({super.key});

  @override
  State<createAppointment> createState() => _createAppointmentState();
}

class _createAppointmentState extends State<createAppointment> {
  String medicineName = 'ketofan';
  FlutterTts flutterTts = FlutterTts();
  List<String> week = [
    "السبت",
    "الاحد",
    "الاثنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعه",
  ];
  Color weekcolor = AppColors.lightmintGreenOp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: const medical_appointment()),
                    );
                  });
                },
                icon: Icon(
                  Icons.arrow_left,
                  size: 45,
                ),
              ),
            ],
          ),
          toolbarHeight: 233,
          backgroundColor: AppColors.mintGreen,
          elevation: 0.0,
          actions: [
            Expanded(child: Container()),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ' انشاء ميعاد دواء جديد',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: Image.asset('assets/images/pictures/todo.png')),
                  ),
                ],
              ),
            ),
            Expanded(child: Container())
          ],
        ),
        body: Column(children: [
          Container(
            width: double.infinity,
            height: 30,
            color: AppColors.mintGreen,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 30,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 72,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromARGB(221, 245, 244, 244)),
                        child: addfield(hint: 'اسم الدواء'))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 72,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromARGB(221, 245, 244, 244)),
                        child: addfield(
                            hint: 'وصف الدواء',
                            assest: 'assets/images/pictures/Path 106.png'))),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 72,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromARGB(221, 245, 244, 244)),
                            child: addfield(
                                hint: 'تكرار الدواء',
                                assest: 'assets/images/pictures/restore.png'))),
                    add_date(name: 'name')
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 60,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (contex, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                weekcolor = AppColors.lightmintGreen;
                              });
                            },
                            child: Container(
                              width: 90,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: weekcolor,
                                  borderRadius: BorderRadius.circular(35)),
                              child: Center(
                                child: Text(week[index]),
                              ),
                            ),
                          ),
                          separatorBuilder: (contex, index) => SizedBox(
                            width: 10,
                          ),
                          itemCount: week.length,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: outlineButton(
                        buttonText: 'الغاء',
                        buttonColor: Colors.red,
                        buttonTextColor: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: outlineButton(
                          buttonText: 'أنشاء',
                          function: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const medical_appointment()));
                          }),
                    ),
                  ],
                ),
                Container(
                  height: 20,
                )
              ]),
            ),
          ),
        ]));
  }
}
