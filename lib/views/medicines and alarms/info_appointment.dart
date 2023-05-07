import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:memory_mate/constants/color_constatnts.dart';

import 'package:page_transition/page_transition.dart';

import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

import '../../components/buttons.dart';
import 'add_field.dart';
import 'medical_appointment.dart';

// ignore: camel_case_types, must_be_immutable
class info_appointment extends StatefulWidget {
  info_appointment({super.key});
  @override
  State<info_appointment> createState() => _info_appointmentState();
  late TextEditingController hourcontroller;
}

// ignore: camel_case_types
class _info_appointmentState extends State<info_appointment> {
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
  var namecontroller = TextEditingController();
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
                    'معلومات عن الدواء ',
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
      body: Column(
        children: [
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
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      editfield(
                          MedicineName: 'اسم الدواء',
                          MedicineDesc: medicineName,
                          AssestImage: 'assets/images/pictures/medicine.png',
                          namecontroller: namecontroller),
                      const SizedBox(
                        height: 7,
                      ),
                      editfield(
                        MedicineName: 'وصف الدواء',
                        MedicineDesc: 'يعالج الصداع ويؤخذ ثلاث مرات بالاسبوع ',
                        AssestImage: 'assets/images/pictures/medicine.png',
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(221, 245, 244, 244),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: _speak,
                                          icon: const Icon(Icons.arrow_left_outlined),
                                          iconSize: 44,
                                        )
                                      ],
                                    ),
                                    Expanded(
                                        child: Container(
                                      width: 50,
                                    )),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: const [
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Expanded(
                                            child: Text(
                                              'نطق الدواء تلقائيا',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: AppColors.darkGrey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Container(
                                        color: AppColors.mintGreen,
                                        height: 55,
                                        width: 1,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 37,
                                      height: 37,
                                      child: Icon(
                                        Icons.volume_up_outlined,
                                        size: 37,
                                        color: AppColors.mintGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                    value: isSelected,
                                                    // ignore: non_constant_identifier_names
                                                    onChanged: (Newvalue) {
                                                      setState(() {
                                                        isSelected = Newvalue!;
                                                      });
                                                    },
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                  );
                                                },
                                              );
                                            },
                                            separatorBuilder:
                                                (context, value) => const SizedBox(
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
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      AppColors.lightmintGreen,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                    elevation:
                                        MaterialStateProperty.all<double>(
                                      0.0,
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'تكرار الدواء ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
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
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                    value: isSelected,
                                                    // ignore: non_constant_identifier_names
                                                    onChanged: (Newvalue) {
                                                      setState(() {
                                                        isSelected = Newvalue!;
                                                      });
                                                    },
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                  );
                                                },
                                              );
                                            },
                                            separatorBuilder:
                                                (context, value) => const SizedBox(
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
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      AppColors.lightmintGreen,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                    elevation:
                                        MaterialStateProperty.all<double>(
                                      0.0,
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'تحديد الايام ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
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
                            height: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: add_date(
                                  name: 'ميعاد الدواء',
                                  hourcontroller: hourcontroller,
                                  mincontroller: mincontroller),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: outlineButton(
                              buttonText: 'حذف',
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
                                            child:
                                                const medical_appointment()));
                                    FlutterAlarmClock.createAlarm(
                                        hour(), min());
                                  }
                                }),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _speak() async {
    await flutterTts.speak(namecontroller.text);
  }
}
