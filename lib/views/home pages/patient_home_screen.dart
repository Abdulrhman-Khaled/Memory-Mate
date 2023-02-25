import 'dart:math';

import 'package:flutter/material.dart';

import 'package:memory_mate/constants/color_constatnts.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String username = 'عبدالرحمن';

    var randomQuatosList = [
      'لعلك تحظي بيوم سعيد',
      'نتمني ان يكون كل شئ بخير',
      'اسعد الله يومك بكل خير وسعادة'
    ];
    final random = Random();
    String element = randomQuatosList[random.nextInt(randomQuatosList.length)];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: height / 6,
              color: AppColors.white,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/images/icons/bar_tree.png',
                      height: height / 6,
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.5),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.menu,
                            color: AppColors.mintGreen,
                            size: 45,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'مرحبا يا $username',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 22, color: AppColors.lightBlack),
                            ),
                            Text(
                              element,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 15, color: AppColors.lightBlack),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.mintGreen,
                          child: Icon(
                            Icons.person,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: width,
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  decoration: const BoxDecoration(
                      color: AppColors.lightmintGreen,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(60))),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Image(
                      width: 290,
                      image: AssetImage(
                        'assets/images/icons/main_tree.png',
                      )),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 130,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.mintGreen,
                                    width: 2,
                                    style: BorderStyle.solid),
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/icons/gps.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "الأماكن وتحديد\nالمواقع",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.lightBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 130,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.mintGreen,
                                    width: 2,
                                    style: BorderStyle.solid),
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/icons/camera.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "الكاميرا",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.lightBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 130,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.mintGreen,
                                    width: 2,
                                    style: BorderStyle.solid),
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/icons/syringe.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "الأدوية",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.lightBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 130,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.mintGreen,
                                    width: 2,
                                    style: BorderStyle.solid),
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/icons/family.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "العائلة والاصدقاء",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.lightBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 130,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.mintGreen,
                                    width: 2,
                                    style: BorderStyle.solid),
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/icons/mental_health.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "الألعاب والممارسات",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.lightBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 130,
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.mintGreen,
                                    width: 2,
                                    style: BorderStyle.solid),
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/icons/todo.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "المهام اليومية",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.lightBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: width,
                    height: 80,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mintGreen,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                        ),
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/icons/who.png',
                          width: 60,
                          height: 60,
                        ),
                        label: const Text(
                          'من تكون ؟',
                          style:
                              TextStyle(color: AppColors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      height: 100,
                      width: width - 65,
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(170, 158, 158, 158),
                              spreadRadius: 0.2,
                              blurRadius: 20,
                              blurStyle: BlurStyle.normal,
                              offset: Offset(0, 10),
                            ),
                          ],
                          color: AppColors.mintGreen,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 130,
                            height: 50,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.chat_outlined,
                                  size: 20,
                                  color: AppColors.mintGreen,
                                ),
                                label: const Text(
                                  'الدردشة',
                                  style: TextStyle(
                                      color: AppColors.mintGreen, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          const Text(
                            "داوم علي انشطتك اليومية\nتناول ادويتك في مواعيدها\nتواصل مع عائلتك, هذا قد\n😊يجعل حياتك افضل",
                            textAlign: TextAlign.right,
                            style:
                                TextStyle(fontSize: 15, color: AppColors.white),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
