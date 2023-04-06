// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/buttons.dart';
import '../../../components/text_fields.dart';
import '../../../constants/color_constatnts.dart';
import 'creat_new_password_screen.dart';

// ignore: must_be_immutable
class SignUpData extends StatefulWidget {
  String title;
  String name;
  String email;
  String phone;
  String type;
  SignUpData(
      {required this.title,
      required this.name,
      required this.email,
      required this.phone,
      required this.type,
      super.key});

  @override
  State<SignUpData> createState() => _SignUpDataState();
}

class _SignUpDataState extends State<SignUpData> {
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final addressFocusNode = FocusNode();
  final dobFocusNode = FocusNode();

  File? avatarImageFile;

 

  DateTime customDateOfBirth = DateTime(2001, 1, 1);
  
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
  Widget build(BuildContext context) {
    dobController.text =
        '${customDateOfBirth.year}/${customDateOfBirth.month}/${customDateOfBirth.day}';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: AppColors.mintGreen,
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'قم بإضافة صورتك الشخصية',
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontSize: 18,
                ),
              ),
              Stack(
                children: [
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                      child: avatarImageFile == null
                          ? const Image(
                              image: AssetImage(
                                  'assets/images/pictures/avatar.png'),
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                avatarImageFile!,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 200,
                              ),
                            )),
                  Positioned(
                    top: 160,
                    right: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: AppColors.white,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            50,
                          ),
                        ),
                        color: AppColors.mintGreen,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo),
                          color: AppColors.white,
                          onPressed: () async {
                            await getImage();
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                  width: 300,
                  labelText: 'العنوان',
                  hintText: '65 شارع السلام, القاهرة',
                  helperText: 'أدخل عنوان سكنك الحالي',
                  focusNode: addressFocusNode,
                  iconLead: Icons.location_on,
                  textFormController: addressController,
                  textType: TextInputType.streetAddress,
                  function: () {},
                  validatText: 'لا يمكن ترك هذا الحقل فارغ',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: textField(
                    width: 300,
                    readOnly: true,
                    labelText: 'تاريخ الميلاد ',
                    helperText: 'أدخل تاريخ يوم ميلادك',
                    hintText: 'العام/الشهر/اليوم',
                    onTapFunction: () async {
                      DateTime? newDateOfBirth = await showDatePicker(
                          context: context,
                          initialDate: customDateOfBirth,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      if (newDateOfBirth == null) return;
                      setState(() => customDateOfBirth = newDateOfBirth);
                    },
                    iconLead: Icons.calendar_month,
                    focusNode: dobFocusNode,
                    textFormController: dobController,
                    textType: TextInputType.datetime,
                    function: () {},
                    validatText: 'لا يمكن ترك هذا الحقل فارغ'),
              ),
              const SizedBox(
                height: 10,
              ),
              filledButton(
                  width: 300,
                  height: 50,
                  buttonText: 'التالي',
                  buttonColor: AppColors.mintGreen,
                  function: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: CreatPasswordScreen(
                              name: widget.name,
                              email: widget.email,
                              phone: widget.phone,
                              type: widget.type,
                              image: avatarImageFile == null ? "assets/images/pictures/avatar.png" : avatarImageFile!.path,
                              date:
                                  customDateOfBirth.toString().substring(0, 10),
                              address: addressController.value.text,
                            )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                'هناك خطأ في البيانات يرجي إعادة المحاولة')),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
