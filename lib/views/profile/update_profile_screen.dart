import 'dart:io';

import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:memory_mate/views/profile/profile_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/buttons.dart';
import '../../constants/color_constatnts.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  var userName = 'سهيل امجد فاضل';
  var age = 39;
  var phoneNumber = 01553734723;
  var email = 'Sohailamged@gmail.com';
  var address = 'شارع الرحاب ,وسط البلد';
  var type = 'مريض';

  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  File? avatarImageFile;

  getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery, imageQuality: 25)
        .catchError((onError) {
      // ignore: invalid_return_type_for_catch_error
      return Fluttertoast.showToast(msg: onError.toString());
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      setState(() {
        avatarImageFile = image;
      });
    }
    if (image == null) {
      Fluttertoast.showToast(
          msg: 'لم يتم اختيار صورة !', backgroundColor: AppColors.mintGreen);
    } else {}
  }

  @override
  void initState() {
  
  super.initState();
  userNameController.text = userName;
  ageController.text = age.toString();
  phoneController.text = phoneNumber.toString();
  addressController.text = address;
  typeController.text = type;
  emailController.text = email;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mintGreen,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 85, 0, 0),
                    alignment: Alignment.center,
                    child: avatarImageFile == null
                        ? const Image(
                            image:
                                AssetImage('assets/images/pictures/avatar.png'),
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              avatarImageFile!,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),
                          )),
                Positioned(
                  top: 185,
                  right: 115,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.mintGreen,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          50,
                        ),
                      ),
                      color: AppColors.white,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      color: AppColors.mintGreen,
                      onPressed: () {
                        getImage();
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        topRight: Radius.circular(60.0))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340,
                          child: TextFormField(                         
                            controller: userNameController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "الاسم بالكامل",
                              hintText: 'سهيل امجد فاضل',
                              hintStyle: TextStyle(
                                color: AppColors.lightmintGreen,
                              ),
                              prefixIcon: Icon(
                                Icons.person_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340.0,
                          child: TextFormField(
                            
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "العمر",
                              hintText: ' 39 عاما ',
                              hintStyle:
                                  TextStyle(color: AppColors.lightmintGreen),
                              prefixIcon: Icon(
                                Icons.person_outline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340.0,
                          child: TextFormField(
                            
                            controller: phoneController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "الهاتف",
                              hintText: '01553734744 ',
                              hintStyle:
                                  TextStyle(color: AppColors.lightmintGreen),
                              prefixIcon: Icon(
                                Icons.phone_iphone_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 249, 249, 249),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340.0,
                          child: TextFormField(
                            
                            controller: addressController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "العنوان",
                              hintText: '  شارع الرحاب وسط البلد  ',
                              hintStyle:
                                  TextStyle(color: AppColors.lightmintGreen),
                              prefixIcon: Icon(
                                Icons.manage_accounts_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 249, 249, 249),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340.0,
                          child: TextFormField(
                            
                            controller: typeController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: ' الفئة ',
                              hintText: "مريض",
                              hintStyle:
                                  TextStyle(color: AppColors.lightmintGreen),
                              prefixIcon: Icon(
                                Icons.merge_type,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250),
                              borderRadius: BorderRadius.circular(15.0)),
                          width: 340.0,
                          child: TextFormField(
                            
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: ' البريد الالكتروني ',
                              hintText: "Sohailamged@gmail.com",
                              hintStyle:
                                  TextStyle(color: AppColors.lightmintGreen),
                              prefixIcon: Icon(
                                Icons.email_rounded,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      filledButton(
                        width: 340,
                        height: 50,
                        textSize: 20,
                        buttonText: 'تحديث البيانات',
                        function: () {
                          AwesomeDialog(
                            context: context,
                            btnOkColor: AppColors.mintGreen,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'تم التحديث بنجاح',
                            btnOkOnPress: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const ProfileScreen(),
                                ),
                              );
                            },
                            btnOkText: "ًحسنا",
                          ).show();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
