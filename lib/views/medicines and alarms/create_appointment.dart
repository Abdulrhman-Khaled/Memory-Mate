import 'package:flutter/material.dart';

import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:page_transition/page_transition.dart';


import '../../components/buttons.dart';
import '../../constants/color_constatnts.dart';
import 'add_field.dart';

import 'medical_appointment.dart';

// ignore: camel_case_types
class createAppointment extends StatefulWidget {
  const createAppointment({super.key});

  @override
  State<createAppointment> createState() => _createAppointmentState();
}

// ignore: camel_case_types
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
  List<String> rebeat = [
    "مره",
    "مرتين",
    "ثلاث مرات",
    "اربع مرات",
    "خمس مرات",
  ];
  final _formKey = GlobalKey<FormState>();
  var hourcontroller = TextEditingController();
  int hour() {
    String hourString = hourcontroller.text;
    int hour = int.parse(hourString);

    return hour;
  }

  var mincontroller = TextEditingController();
  int min() {
    String minString = mincontroller.text;
    int min = int.parse(minString);

    return min;
  }

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
                icon: const Icon(
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' انشاء ميعاد دواء جديد',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Image.asset('assets/images/pictures/todo.png'),
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
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(221, 245, 244, 244)),
                          child: addfield(hint: 'اسم الدواء'))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(221, 245, 244, 244)),
                          child: addfield(
                              hint: 'وصف الدواء',
                              assest: 'assets/images/pictures/Path 106.png'))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      add_date(
                          name: 'name',
                          hourcontroller: hourcontroller,
                          mincontroller: mincontroller)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                bool isSelected = false;
                                return AlertDialog(
                                  title: const Text('اختر عدد تكرار الدواء'),
                                  content: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return CheckboxListTile(
                                            title: Text(
                                              rebeat[index],
                                              textDirection: TextDirection.rtl,
                                            ),
                                            value: isSelected,
                                            // ignore: non_constant_identifier_names
                                            onChanged: (Newvalue) {
                                              setState(() {
                                                isSelected = Newvalue!;
                                              });
                                            },
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, value) =>
                                        const SizedBox(
                                      height: 8,
                                    ),
                                    itemCount: 5,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('الغاء'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Perform action with selected option
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('حسنا'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.lightmintGreen,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(
                              0.0,
                            ),
                          ),
                          child: SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'تكرار الدواء ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Container(
                                    height: 30,
                                    width: 1,
                                    color: AppColors.white,
                                  ),
                                ),
                                const Icon(Icons.access_time),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                bool isSelected = false;
                                return AlertDialog(
                                  title: const Text('اختر عدد الايام '),
                                  content: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return CheckboxListTile(
                                            title: Text(
                                              week[index],
                                              textDirection: TextDirection.rtl,
                                            ),
                                            value: isSelected,
                                            // ignore: non_constant_identifier_names
                                            onChanged: (Newvalue) {
                                              setState(() {
                                                isSelected = Newvalue!;
                                              });
                                            },
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                          );
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, value) =>
                                        const SizedBox(
                                      height: 8,
                                    ),
                                    itemCount: week.length,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('الغاء'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Perform action with selected option
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('حسنا'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.lightmintGreen,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(
                              0.0,
                            ),
                          ),
                          child: SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'تحديد الايام ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Container(
                                    height: 30,
                                    width: 1,
                                    color: AppColors.white,
                                  ),
                                ),
                                const Icon(Icons.calendar_month),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
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
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: outlineButton(
                            buttonText: 'تعديل',
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const medical_appointment()));
                                FlutterAlarmClock.createAlarm(hour(), min());
                              }
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
          ),
        ]));
  }
}
