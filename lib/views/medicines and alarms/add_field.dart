import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

import '../../constants/color_constatnts.dart';



Widget addfield({
  required String hint,
  String assest = 'assets/images/pictures/medicine.png',
  double height = 83,
  double iconSize = 35,
}) =>
    Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 100,
            child: TextField(
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
          SizedBox(
            width: 10,
          ),
          Container(
            width: 1.2,
            color: AppColors.mintGreen,
            height: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 30,
              height: 30,
              child: Image.asset(assest),
            ),
          ),
        ],
      ),
    );
Widget add_date(
        {required String name, double height = 83, double iconSize = 35}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 80,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(221, 245, 244, 244)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                              child: Text(
                                'ميعاد الدواء',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 121, 121, 121)),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  child: TextField(
                                    textDirection: TextDirection.rtl,
                                    cursorHeight: 25,
                                    decoration: InputDecoration(
                                      hintText: '00',
                                      hintTextDirection: TextDirection.rtl,
                                      hintStyle: TextStyle(
                                          color: AppColors.lightBlack,
                                          fontSize: 19),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 7, left: 8, right: 8),
                                    child: Text(
                                      ':',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  child: TextField(
                                    textDirection: TextDirection.rtl,
                                    cursorHeight: 25,
                                    decoration: InputDecoration(
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
                  Container(
                    width: 25,
                    height: 25,
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
        {required String MedicineName,
        required String MedicineDesc,
        String AssestImage = 'اي شيء',
        double height = 83,
        double iconSize = 35}) =>
    Column(
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color.fromARGB(221, 245, 244, 244)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Container(
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
                                  child: Container(
                                    child: Text(
                                      MedicineName,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(
                                              255, 121, 121, 121)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          child: TextField(
                            textDirection: TextDirection.rtl,
                            cursorHeight: 25,
                            decoration: InputDecoration(
                              hintText: MedicineDesc,
                              hintTextDirection: TextDirection.rtl,
                              hintStyle: TextStyle(
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
                Container(
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
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        height: 37,
        child: TextField(
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.mintGreen,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50)),
              focusedBorder: OutlineInputBorder(
                  gapPadding: 4,
                  borderSide: BorderSide(
                    color: AppColors.mintGreen,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50)),
              suffixIcon: Icon(Icons.search),
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.sort_sharp),
              ),
              contentPadding: EdgeInsets.only(top: 15),
              hintText: 'ابحث عن ميعاد معين',
              hintTextDirection: TextDirection.rtl,
              hintStyle: TextStyle(
                fontSize: 20,
              )),
          cursorHeight: 20,
          cursorRadius: Radius.circular(50),
        ),
      ),
    );

Widget appointment(
        {double width = double.infinity,
        double height = 500.0,
        Color contcolor = const Color.fromARGB(255, 238, 236, 236),
        double textSize = 17,
        required String medicineName,
        String medicineDate = 'صباحا 12:00 - السبت والاحد والاتنين ',
        String medicinetime = 'ينطلق المنبه خلال  :6 ساعات و 30 دقيقه',
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
                          Container(
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
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
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
                          Text(
                            medicinetime,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: textSize,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
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
                      medicinerebeat,
                      style: TextStyle(
                        fontSize: textSize,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 25,
                      height: 25,
                      child: Container(
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
