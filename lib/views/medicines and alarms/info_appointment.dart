import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:page_transition/page_transition.dart';


import '../../components/buttons.dart';
import 'add_field.dart';
import 'medical_appointment.dart';

class info_appointment extends StatefulWidget {
  const info_appointment({super.key});

  @override
  State<info_appointment> createState() => _info_appointmentState();
}

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
                    'معلومات عن الدواء ',
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
                child: Column(
                  children: [
                    editfield(
                        MedicineName: 'اسم الدواء',
                        MedicineDesc: medicineName,
                        AssestImage: 'assets/images/pictures/medicine.png'),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                  Container(
                                    width: 37,
                                    height: 37,
                                    child: const Icon(
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
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 83,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Color.fromARGB(221, 245, 244, 244)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                width: 100,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15),
                                                  child: Container(
                                                    child: const Text(
                                                      'تكرار الدواء',
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255,
                                                              121,
                                                              121,
                                                              121)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                child: TextField(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  cursorHeight: 25,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'ثلالث مرات يوميا',
                                                    hintTextDirection:
                                                        TextDirection.rtl,
                                                    hintStyle: TextStyle(
                                                        color: AppColors
                                                            .lightBlack,
                                                        fontSize: 19),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 65,
                                          width: 1,
                                          color: AppColors.mintGreen,
                                        ),
                                      ),
                                      Container(
                                        width: 25,
                                        height: 25,
                                        child: Image.asset(
                                            'assets/images/pictures/medicine.png'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          add_date(name: 'ميعاد الدواء')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                            buttonText: 'حذف',
                            buttonColor: Colors.red,
                            buttonTextColor: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: outlineButton(
                              buttonText: 'تعديل',
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
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _speak() async {
    await flutterTts.speak(medicineName);
  }
}
