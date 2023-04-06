import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memory_mate/views/profile/update_profile_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/buttons.dart';
import '../../constants/color_constatnts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "سهيل امجد فاضل";
  int age = 39;
  String number = '01553734744';
  String email = "sohailamged@gmail.com";
  String address = "شارع الرحاب وسط البلد";
  String type = "مريض";

  File? avatarImageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mintGreen,
        body: Column(children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/pictures/bar_tree.png',
                  height: 150.0,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                alignment: Alignment.center,
                child: const Text(
                  'الملف الشخصي',
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.white,
                  ),
                ),
              ),
              avatarImageFile == null
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(0, 85, 0, 0),
                      alignment: Alignment.center,
                      child: const Image(
                        image: AssetImage('assets/images/pictures/avatar.png'),
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.fromLTRB(0, 85, 0, 0),
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          avatarImageFile!,
                          fit: BoxFit.cover,
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: 280.0,
                          padding: const EdgeInsets.all(15.0),
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              'الأسم : $username',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 16, color: AppColors.lightBlack),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.person_outlined,
                        color: AppColors.mintGreen,
                        size: 30,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: 280.0,
                          padding: const EdgeInsets.all(15.0),
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              'العمر : $age عام',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 16, color: AppColors.lightBlack),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.mintGreen,
                        size: 30.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: 280.0,
                          padding: const EdgeInsets.all(15.0),
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              'رقم الهاتف  :  $number',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 16, color: AppColors.lightBlack),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.phone_iphone_outlined,
                        color: AppColors.mintGreen,
                        size: 30.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: 280.0,
                          padding: const EdgeInsets.all(15.0),
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              '$email  :  الإيميل',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 16, color: AppColors.lightBlack),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.email_outlined,
                        color: AppColors.mintGreen,
                        size: 30.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: 280.0,
                          padding: const EdgeInsets.all(15.0),
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              'العنوان : $address',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.lightBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.mintGreen,
                        size: 30.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          width: 280.0,
                          padding: const EdgeInsets.all(15.0),
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 245, 245),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              'الفئة : $type',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 16, color: AppColors.lightBlack),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.merge_type_rounded,
                        color: AppColors.mintGreen,
                        size: 30.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: filledButton(
                      width: 308,
                      height: 50,
                      textSize: 20,
                      buttonText: 'تحديث الملف الشخصي',
                      function: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const UpdateProfileScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ))
        ]));
  }
}
