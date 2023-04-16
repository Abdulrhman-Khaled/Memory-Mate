import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_mate/models/add_care_giver.dart';

import '../../components/text_fields.dart';
import '../../constants/color_constatnts.dart';

class FamilyAndFriendsScreen extends StatefulWidget {
  const FamilyAndFriendsScreen({super.key});

  @override
  State<FamilyAndFriendsScreen> createState() => _FamilyAndFriendsScreenState();
}

class _FamilyAndFriendsScreenState extends State<FamilyAndFriendsScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  List<AddCareGiver> careGiversList = [];

  var careNameController = TextEditingController();
  var careRelationController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final careNameFocusNode = FocusNode();
  final careRelationFocusNode = FocusNode();

  FileImage? careGiverImageFile;
  ImageProvider tempAvatarImage =
      const AssetImage('assets/images/pictures/avatar.png');

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

  void addNewCareGiver(AddCareGiver careGiver) {
    setState(() {
      // Update state
      careGiversList.add(careGiver);
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void startAnimation() {
    if (!_controller!.isAnimating) {
      _controller!.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.mintGreen,
            elevation: 4.0,
            child: const Icon(Icons.group_add_outlined),
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: const Center(
                          child: Text(
                            'إضافة شخص',
                            style: TextStyle(
                                fontSize: 25, color: AppColors.mintGreen),
                          ),
                        ),
                        content: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 15, 0, 20),
                                          child: careGiverImageFile == null
                                              ? const Image(
                                                  image: AssetImage(
                                                      'assets/images/pictures/avatar.png'),
                                                  fit: BoxFit.cover,
                                                  width: 150,
                                                  height: 150,
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image(
                                                    image: careGiverImageFile!,
                                                    fit: BoxFit.cover,
                                                    width: 150,
                                                    height: 150,
                                                  ),
                                                )),
                                      Positioned(
                                        top: 120,
                                        right: 60,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: AppColors.white,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                50,
                                              ),
                                            ),
                                            color: AppColors.mintGreen,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: IconButton(
                                              icon:
                                                  const Icon(Icons.add_a_photo),
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
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: textField(
                                        width: 300,
                                        fillColor: AppColors.white,
                                        labelText: 'اسم الشخص',
                                        helperText: 'أدخل اسم الشخص الذي تعرفه',
                                        hintText: "محمد احمد",
                                        iconLead: Icons.person_outlined,
                                        focusNode: careNameFocusNode,
                                        textFormController: careNameController,
                                        textType: TextInputType.text,
                                        function: () {},
                                        validatText:
                                            'لا يمكن ترك هذا الحقل فارغ'),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: textField(
                                        width: 300,
                                        fillColor: AppColors.white,
                                        labelText: 'العلاقة',
                                        helperText:
                                            'أدخل علاقة او صلة قرابة الشخص بك',
                                        hintText: 'ابن خالتي',
                                        iconLead: Icons.link,
                                        focusNode: careRelationFocusNode,
                                        textFormController:
                                            careRelationController,
                                        textType: TextInputType.multiline,
                                        function: () {},
                                        validatText:
                                            'لا يمكن ترك هذا الحقل فارغ'),
                                  ),
                                ],
                              ),
                            )),
                        actions: <Widget>[
                          InkWell(
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
                                child: const Text(
                                  'إلغاء',
                                  style: TextStyle(
                                    color: AppColors.mintGreen,
                                    fontSize: 20,
                                  ),
                                )),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          InkWell(
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
                                child: const Text(
                                  'إضافة',
                                  style: TextStyle(
                                    color: AppColors.mintGreen,
                                    fontSize: 20,
                                  ),
                                )),
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                if (careGiverImageFile != null) {
                                  addNewCareGiver(AddCareGiver(
                                      careName: careNameController.value.text,
                                      careRelation:
                                          careRelationController.value.text,
                                      careImage: careGiverImageFile));
                                  Navigator.of(context).pop();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'لا يمكن إضافة شخص بدون صورة !',
                                      backgroundColor: AppColors.mintGreen);
                                }
                              }
                            },
                          ),
                        ],
                      );
                    });
                  });
            }),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          iconTheme: const IconThemeData(
            color: AppColors.mintGreen,
          ),
          centerTitle: true,
          title: const Text(
            'العائلة والاصدقاء',
            style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
          ),
        ),
        body: careGiversList.isEmpty
            ? const Center(
                child: Text(
                  'لم يتم إضافة اي اشخاص بعد',
                  style: TextStyle(fontSize: 22, color: AppColors.mintGreen),
                ),
              )
            : ListView.builder(
                itemCount: careGiversList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        color: Colors.red,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'حذف',
                                style: TextStyle(
                                    fontSize: 20, color: AppColors.white),
                              ),
                              Icon(
                                Icons.delete_outline,
                                color: AppColors.white,
                                size: 35,
                              ),
                            ]),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          careGiversList.removeAt(index);
                        });
                      },
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'تأكيد حذف الشخص',
                                textAlign: TextAlign.center,
                              ),
                              content: const Text(
                                'هل تريد حذف هذا الشخص بالفعل؟',
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('إلغاء'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text('حذف'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Card(
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: const Color.fromARGB(255, 244, 244, 244),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 10, 10, 10),
                                child: Image(
                                    width: 100,
                                    height: 100,
                                    image: careGiversList[index].careImage!),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    careGiversList[index].careName!,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    careGiversList[index].careRelation!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                }));
  }
}
