import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_mate/models/add_care_giver.dart';

import '../../constants/color_constatnts.dart';

class MyCareGiversScreen extends StatefulWidget {
  const MyCareGiversScreen({super.key});

  @override
  State<MyCareGiversScreen> createState() => _MyCareGiversScreenState();
}

class _MyCareGiversScreenState extends State<MyCareGiversScreen> {

  var careNameController = TextEditingController();
  var careRelationController = TextEditingController();
  
  var formKey = GlobalKey<FormState>();

  final careNameFocusNode = FocusNode();
  final careRelationFocusNode = FocusNode();

  FileImage? careGiverImageFile;
  ImageProvider memoryAddImage =
      const AssetImage('assets/images/pictures/add_memory.png');
  ImageProvider memoryTempImage =
      const AssetImage('assets/images/pictures/memory.png');

      List<AddCareGiver> addCareGiverList = [];

      getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery, imageQuality: 25)
        .catchError((onError) {
      // ignore: invalid_return_type_for_catch_error
      return Fluttertoast.showToast(msg: onError.toString());
    });
    FileImage? image;
    if (pickedFile != null) {
      dynamic temp = File(pickedFile.path);
      image = FileImage(temp);
    }
    if (image != null) {
      setState(() {
        careGiverImageFile = image;
      });
    }
    if (image == null) {
      Fluttertoast.showToast(
          msg: 'لم يتم اختيار صورة !', backgroundColor: AppColors.mintGreen);
    } else {}
  }

  void addNewCareGiver(AddCareGiver addCareGiver) {
    setState(() {
      // Update state
      addCareGiverList.add(addCareGiver);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: AppColors.mintGreen,
        ),
        centerTitle: true,
        title: const Text(
          'إعادة تعيين كلمة المرور',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
    );
  }
}