import 'dart:io';


import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:memory_mate/models/memories.dart';

import 'package:memory_mate/views/profile/profile_screen.dart';
import '../../components/buttons.dart';
import '../../components/text_fields.dart';
import '../../constants/color_constatnts.dart';
import 'family_and_friends_screen.dart';

class WhoIAmScreen extends StatefulWidget {
  const WhoIAmScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WhoIAmScreen> createState() => _WhoIAmScreenState();
}

class _WhoIAmScreenState extends State<WhoIAmScreen> {
  var addressController = TextEditingController();
  var dateController = TextEditingController();
  var contentController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final addressFocusNode = FocusNode();
  final dateFocusNode = FocusNode();
  final contentFocusNode = FocusNode();

  DateTime customDateOfBirth = DateTime(2001, 1, 1);

  FileImage? memoryImageFile;
  ImageProvider memoryAddImage =
      const AssetImage('assets/images/pictures/add_memory.png');
  ImageProvider memoryTempImage =
      const AssetImage('assets/images/pictures/memory.png');

  File? avatarImageFile;

  List<Memories> memoriesList = [];

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
        memoryImageFile = image;
      });
    }
    if (image == null) {
      Fluttertoast.showToast(
          msg: 'لم يتم اختيار صورة !', backgroundColor: AppColors.mintGreen);
    } else {}
  }

  void addNewMemory(Memories memory) {
    setState(() {
      // Update state
      memoriesList.add(memory);
    });
  }

  @override
  Widget build(BuildContext context) {
    String username = 'سهيل امجد فاضل';
    var age = 39;
    var address = 'شارع الرحاب ,وسط البلد';

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: AppColors.mintGreen,
        ),
        centerTitle: true,
        title: const Text(
          'من تكون ؟',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: [
                filledIconButton(
                  width: 165,
                  function: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: const ProfileScreen()),
                    );
                  },
                  buttonIcon: Icons.person_search_outlined,
                  buttonText: 'الملف الشخصي',
                  textSize: 15,
                ),
                const Spacer(),
                avatarImageFile == null
                    ? const Image(
                        image: AssetImage('assets/images/pictures/avatar.png'),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          avatarImageFile!,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 25, 0),
            alignment: Alignment.centerRight,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightBlack,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '$age عام',
                    style: const TextStyle(
                        color: AppColors.lightBlack, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    address,
                    style: const TextStyle(
                        color: AppColors.lightBlack, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                filledIconButton(
                  width: 170,
                  height: 60,
                  function: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: FamilyAndFriendsScreen()),
                    );
                  },
                  buttonIcon: Icons.people_alt_rounded,
                  buttonText: 'العائلة والاصدقاء',
                  textSize: 16,
                ),
                const Spacer(),
                filledIconButton(
                    width: 170,
                    height: 60,
                    buttonIcon: Icons.post_add_sharp,
                    buttonText: 'إضافة ذكرى',
                    textSize: 16,
                    function: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              dateController.text =
                                  '${customDateOfBirth.year}/${customDateOfBirth.month}/${customDateOfBirth.day}';
                              return AlertDialog(
                                title: const Center(
                                  child: Text(
                                    'إضافة ذكري',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: AppColors.mintGreen),
                                  ),
                                ),
                                content: Form(
                                    key: formKey,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: textField(
                                                width: 300,
                                                needMax: true,
                                                maxLetters: 30,
                                                fillColor: AppColors.white,
                                                labelText: 'مكان الذكري',
                                                helperText: 'أدخل مكان الذكري',
                                                hintText:
                                                    "القاهرة, المتحف المصري",
                                                iconLead:
                                                    Icons.location_on_outlined,
                                                focusNode: addressFocusNode,
                                                textFormController:
                                                    addressController,
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
                                                needMax: true,
                                                maxLetters: 200,
                                                fillColor: AppColors.white,
                                                labelText: 'احداث الذكري',
                                                helperText:
                                                    'أدخل احداث ومحتوي الذكري',
                                                hintText: "",
                                                minlines: 3,
                                                maxlines: 8,
                                                iconLead:
                                                    Icons.message_outlined,
                                                focusNode: contentFocusNode,
                                                textFormController:
                                                    contentController,
                                                textType:
                                                    TextInputType.multiline,
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
                                                readOnly: true,
                                                fillColor: AppColors.white,
                                                labelText: 'تاريخ الذكري ',
                                                helperText:
                                                    'أدخل تاريخ يوم الذكري',
                                                hintText: 'العام/الشهر/اليوم',
                                                onTapFunction: () async {
                                                  DateTime? newDateOfBirth =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              customDateOfBirth,
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime(2100));
                                                  if (newDateOfBirth == null) {
                                                    return;
                                                  }

                                                  setState(() {
                                                    customDateOfBirth =
                                                        newDateOfBirth;
                                                  });
                                                },
                                                iconLead: Icons.calendar_month,
                                                focusNode: dateFocusNode,
                                                textFormController:
                                                    dateController,
                                                textType:
                                                    TextInputType.datetime,
                                                function: () {},
                                                validatText:
                                                    'لا يمكن ترك هذا الحقل فارغ'),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await getImage();
                                              setState(() {});
                                            },
                                            child: Container(
                                                color: AppColors.mintGreen,
                                                width: 300,
                                                height: 200,
                                                child: Image(
                                                    image: memoryImageFile ==
                                                            null
                                                        ? memoryAddImage
                                                        : memoryImageFile!)),
                                          ),
                                        ],
                                      ),
                                    )),
                                actions: <Widget>[
                                  InkWell(
                                    child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 15, 10),
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
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 15, 10),
                                        child: const Text(
                                          'إضافة',
                                          style: TextStyle(
                                            color: AppColors.mintGreen,
                                            fontSize: 20,
                                          ),
                                        )),
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        memoryImageFile == null
                                            ? addNewMemory(Memories(
                                                address: addressController.text,
                                                date: dateController.text,
                                                content: contentController.text,
                                                image: memoryTempImage))
                                            : addNewMemory(Memories(
                                                address: addressController.text,
                                                date: dateController.text,
                                                content: contentController.text,
                                                image: memoryImageFile));
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ],
                              );
                            });
                          });
                    }),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 232, 232, 232),
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "ذكرياتك",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.mintGreen,
                        ),
                      ),
                      const Divider(),
                      memoriesList.isEmpty
                          ? const Expanded(
                              child: Center(
                                child: Text(
                                  'لم يتم إضافة اي ذكريات بعد',
                                  style: TextStyle(
                                      fontSize: 22, color: AppColors.mintGreen),
                                ),
                              ),
                            )
                          : Flexible(
                              child: ListView.builder(
                                  itemCount: memoriesList.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                        key: UniqueKey(),
                                        direction: DismissDirection.endToStart,
                                        background:
                                            Container(color: Colors.red),
                                        onDismissed: (direction) {
                                          setState(() {
                                            memoriesList.removeAt(index);
                                          });
                                        },
                                        child: Card(
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          color: const Color.fromARGB(
                                              255, 244, 244, 244),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Image(
                                                      image: memoriesList[index]
                                                          .image!)),
                                              Expanded(
                                                flex: 3,
                                                child: ListTile(
                                                  title: Text(
                                                      memoriesList[index]
                                                          .address!),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(memoriesList[index]
                                                          .date!),
                                                      Text(memoriesList[index]
                                                          .content!),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ));
                                  }),
                            )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
