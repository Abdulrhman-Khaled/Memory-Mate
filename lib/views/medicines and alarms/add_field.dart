

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

import '../../constants/color_constatnts.dart';

FlutterTts flutterTts = FlutterTts();
dynamic _speak(String medName) async {
  await flutterTts.speak(medName);
}

Widget addfield({
  required String hint,
  IconData? icon,
  IconData? sufIcon,
  double height = 75,
  double iconSize = 35,
  String text = 'لا يمكن ترك هذا الحقل فارغ',
  bool enableEdit = true,
  Future<dynamic>? sufClick,
  TextEditingController? controller,
}) =>
    SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 300,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
                enabled: enableEdit,
                cursorHeight: 25,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    child: Icon(
                      sufIcon,
                      size: 30,
                      color: AppColors.mintGreen,
                    ),
                    onTap: () => sufClick,
                  ),
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: const TextStyle(color: AppColors.lightBlack),
                  hintTextDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 1.5,
            color: AppColors.mintGreen,
            height: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Icon(
              icon,
              size: 32,
              color: AppColors.mintGreen,
            ),
          ),
        ],
      ),
    );

Widget addfield2({
  required String hint,
  String assest = 'assets/images/pictures/medicine.png',
  IconData icon = Icons.label_outline,
  double height = 83,
  double iconSize = 35,
  String text = "يرجي ملأ هذا الفراغ",
  required TextEditingController nameController,
}) =>
    SizedBox(
      height: 70,
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 120,
            child: TextFormField(
              controller: nameController,
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
            width: 1.5,
            color: AppColors.mintGreen,
            height: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14),
              child: Icon(icon, size: 30, color: AppColors.mintGreen),
            ),
          ),
        ],
      ),
    );

Widget appointment({
  double width = double.infinity,
  double height = 500.0,
  Color contcolor = const Color.fromARGB(255, 238, 236, 236),
  double textSize = 17,
  required String medicineName,
  required String medicineDate,
  required String medicinetime,
  required String medicineRepeat,
}) =>
    Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: contcolor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          medicineName,
                          overflow: TextOverflow.ellipsis,
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
              const SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 25,
                      height: 25,
                      child: Icon(
                        Icons.alarm_on_sharp,
                        color: AppColors.mintGreen,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        medicineDate,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: textSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () => _speak(medicineName),
                      child: const Icon(
                        Icons.play_circle_outline,
                        size: 32,
                        color: AppColors.mintGreen,
                      )),
                  const Spacer(),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      medicineRepeat,
                      style: TextStyle(
                        fontSize: textSize,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 25,
                    height: 25,
                    child: Icon(
                      Icons.repeat_outlined,
                      color: AppColors.mintGreen,
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
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
                    child: Icon(
                      Icons.timelapse,
                      color: AppColors.mintGreen,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
