
import 'package:flutter/material.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

import '../../constants/color_constatnts.dart';



Widget addfield({
  required String hint,
  String assest = 'assets/images/pictures/medicine.png',
  double height = 83,
  double iconSize = 35,
  String text = "يرجي ملأ هذا الفراغ",
}) =>
    SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 100,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return text;
                }
                return null;
              },
              cursorHeight: 25,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintMaxLines: 2,
                border: InputBorder.none,
                hintText: hint,
                hintTextDirection: TextDirection.rtl,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 1.2,
            color: AppColors.mintGreen,
            height: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 30,
              height: 30,
              child: Image.asset(assest),
            ),
          ),
        ],
      ),
    );
// ignore: non_constant_identifier_names
Widget add_date({
  required String name,
  double height = 83,
  double iconSize = 35,
  required TextEditingController hourcontroller,
  required TextEditingController mincontroller,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color.fromARGB(221, 245, 244, 244)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 150,
                          height: 25,
                          child: Center(
                            child: Text(
                              'ميعاد الدواء',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 121, 121, 121)),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(child: Container()),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: hourcontroller,
                                    textDirection: TextDirection.rtl,
                                    cursorHeight: 25,
                                    decoration: const InputDecoration(
                                      hintText: '00',
                                      hintTextDirection: TextDirection.rtl,
                                      hintStyle: TextStyle(
                                          color: AppColors.lightBlack,
                                          fontSize: 19),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 7, left: 8, right: 8),
                                  child: Text(
                                    ':',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: mincontroller,
                                    textDirection: TextDirection.rtl,
                                    cursorHeight: 25,
                                    decoration: const InputDecoration(
                                      hintText: '00',
                                      hintTextDirection: TextDirection.rtl,
                                      hintStyle: TextStyle(
                                          color: AppColors.lightBlack,
                                          fontSize: 19),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 65,
                      width: 1,
                      color: AppColors.mintGreen,
                    ),
                  ),
                  SizedBox(
                    width: 37,
                    height: 37,
                    child: Image.asset('assets/images/pictures/medicine.png'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
Widget editfield(
        // ignore: non_constant_identifier_names
        {required String MedicineName,
        // ignore: non_constant_identifier_names
        required String MedicineDesc,
        // ignore: non_constant_identifier_names
        String AssestImage = 'اي شيء',
        double height = 105,
        var namecontroller,
        double iconSize = 35}) =>
    Column(
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: const Color.fromARGB(221, 245, 244, 244)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 50,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    MedicineName,
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(
                                            255, 121, 121, 121)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: namecontroller,
                            textDirection: TextDirection.rtl,
                            cursorHeight: 25,
                            decoration: InputDecoration(
                              hintText: MedicineDesc,
                              hintTextDirection: TextDirection.rtl,
                              hintStyle: const TextStyle(
                                  color: AppColors.lightBlack, fontSize: 19),
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
                SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: Image.asset('assets/images/pictures/medicine.png'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
Widget search() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 37,
        child: TextField(
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.mintGreen,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50)),
              focusedBorder: OutlineInputBorder(
                  gapPadding: 4,
                  borderSide: const BorderSide(
                    color: AppColors.mintGreen,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50)),
              suffixIcon: const Icon(Icons.search),
              prefixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.sort_sharp),
              ),
              contentPadding: const EdgeInsets.only(top: 15),
              hintText: 'ابحث عن ميعاد معين',
              hintTextDirection: TextDirection.rtl,
              hintStyle: const TextStyle(
                fontSize: 20,
              )),
          cursorHeight: 20,
          cursorRadius: const Radius.circular(50),
        ),
      ),
    );

Widget appointment(
        {double width = double.infinity,
        double height = 500.0,
        Color contcolor = const Color.fromARGB(255, 238, 236, 236),
        double textSize = 17,
        required String medicineName,
        required String medicineDate,
        required String medicinetime,
        String medicinerebeat = 'يتكرر لمده ثلاث ايام في الاسبوع'}) =>
    Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: contcolor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 50,
                            child: Switcher(
                              value: false,
                              size: SwitcherSize.small,
                              switcherButtonRadius: 50,
                              enabledSwitcherButtonRotate: true,
                              colorOff: AppColors.lightGrey.withOpacity(0.3),
                              colorOn: AppColors.mintGreen,
                              onChanged: (bool state) {
                                //
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            medicineName,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Image.asset(
                                'assets/images/pictures/medicine.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            medicineDate,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: textSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 25,
                      height: 25,
                      child: Icon(
                        Icons.alarm_on_sharp,
                        color: AppColors.mintGreen,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      medicinetime,
                      style: TextStyle(
                        fontSize: textSize,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 25,
                      height: 25,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.timelapse,
                          color: AppColors.mintGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
