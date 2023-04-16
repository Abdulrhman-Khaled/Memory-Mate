import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/networking/dio/repositories/patient_user_repsitory.dart';
import 'package:page_transition/page_transition.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:memory_mate/models/memories.dart';

import 'package:memory_mate/views/profile/profile_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../../components/buttons.dart';
import '../../components/text_fields.dart';
import '../../constants/color_constatnts.dart';

import '../../networking/dio/api/dio_client.dart';
import '../../networking/dio/models api/patient_user_api.dart';

class WhoIAmScreen extends StatefulWidget {
  const WhoIAmScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WhoIAmScreen> createState() => _WhoIAmScreenState();
}

class _WhoIAmScreenState extends State<WhoIAmScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  var addressController = TextEditingController();
  var dateController = TextEditingController();
  var contentController = TextEditingController();

  late Dio dio;
  late DioClient dioClient;
  late PatientUserApi userApi;
  late PatientUserRepository patientUserRepository;

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

  String userName = '';

  String imageLink = '';

  String address = '';

  String age = '';

  bool isLoading = true;

  List<Memories> memoriesList = [];

  SimpleFontelicoProgressDialog? prograssDialog;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> refresh() async {
    getUserInfo();
    setState(() {});
    refreshController.refreshCompleted();
  }

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

  Future<void> showPrograssDialog() async {
    prograssDialog!
        .show(message: "جاري التحميل...", indicatorColor: AppColors.mintGreen);
  }

  Future<void> hidePrograssDialog() async {
    prograssDialog!.hide();
  }

  void addNewMemory(Memories memory) {
    setState(() {
      // Update state
      memoriesList.add(memory);
    });
  }

  String ageCalculator(String date) {
    String dateString = date;
    DateTime birthDate = DateTime.parse(dateString);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('currentUserToken');
    Map<String, dynamic> userInformation =
        await patientUserRepository.getPatientUserRequest(userToken!);
    String dob = ageCalculator(userInformation['dob']);

    log(userInformation.toString());
    setState(() {
      userName = userInformation['name'];
      imageLink = userInformation['avatar'];
      address = userInformation['address'];
      age = dob;
      isLoading = false;
    });

    return userInformation;
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
    prograssDialog = SimpleFontelicoProgressDialog(context: context);
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.mintGreen,
              backgroundColor: AppColors.white,
            ))
          : SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              onRefresh: refresh,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        imageLink,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    alignment: Alignment.center,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userName,
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
                                  child: const ProfileScreen()),
                            );
                          },
                          buttonIcon: Icons.person_search_outlined,
                          buttonText: 'الملف الشخصي',
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
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: textField(
                                                        width: 300,
                                                        needMax: true,
                                                        maxLetters: 30,
                                                        fillColor:
                                                            AppColors.white,
                                                        labelText:
                                                            'مكان الذكري',
                                                        helperText:
                                                            'أدخل مكان الذكري',
                                                        hintText:
                                                            "القاهرة, المتحف المصري",
                                                        iconLead: Icons
                                                            .location_on_outlined,
                                                        focusNode:
                                                            addressFocusNode,
                                                        textFormController:
                                                            addressController,
                                                        textType:
                                                            TextInputType.text,
                                                        function: () {},
                                                        validatText:
                                                            'لا يمكن ترك هذا الحقل فارغ'),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: textField(
                                                        width: 300,
                                                        needMax: true,
                                                        maxLetters: 200,
                                                        fillColor:
                                                            AppColors.white,
                                                        labelText:
                                                            'احداث الذكري',
                                                        helperText:
                                                            'أدخل احداث ومحتوي الذكري',
                                                        hintText: "",
                                                        minlines: 3,
                                                        maxlines: 8,
                                                        iconLead: Icons
                                                            .message_outlined,
                                                        focusNode:
                                                            contentFocusNode,
                                                        textFormController:
                                                            contentController,
                                                        textType: TextInputType
                                                            .multiline,
                                                        function: () {},
                                                        validatText:
                                                            'لا يمكن ترك هذا الحقل فارغ'),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: textField(
                                                        width: 300,
                                                        readOnly: true,
                                                        fillColor:
                                                            AppColors.white,
                                                        labelText:
                                                            'تاريخ الذكري ',
                                                        helperText:
                                                            'أدخل تاريخ يوم الذكري',
                                                        hintText:
                                                            'العام/الشهر/اليوم',
                                                        onTapFunction:
                                                            () async {
                                                          DateTime?
                                                              newDateOfBirth =
                                                              await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      customDateOfBirth,
                                                                  firstDate:
                                                                      DateTime(
                                                                          1900),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2100));
                                                          if (newDateOfBirth ==
                                                              null) {
                                                            return;
                                                          }

                                                          setState(() {
                                                            customDateOfBirth =
                                                                newDateOfBirth;
                                                          });
                                                        },
                                                        iconLead: Icons
                                                            .calendar_month,
                                                        focusNode:
                                                            dateFocusNode,
                                                        textFormController:
                                                            dateController,
                                                        textType: TextInputType
                                                            .datetime,
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
                                                        color:
                                                            AppColors.mintGreen,
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
                                                margin:
                                                    const EdgeInsets.fromLTRB(
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
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 15, 10),
                                                child: const Text(
                                                  'إضافة',
                                                  style: TextStyle(
                                                    color: AppColors.mintGreen,
                                                    fontSize: 20,
                                                  ),
                                                )),
                                            onTap: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                memoryImageFile == null
                                                    ? addNewMemory(Memories(
                                                        address:
                                                            addressController
                                                                .text,
                                                        date:
                                                            dateController.text,
                                                        content:
                                                            contentController
                                                                .text,
                                                        image: memoryTempImage))
                                                    : addNewMemory(Memories(
                                                        address:
                                                            addressController
                                                                .text,
                                                        date:
                                                            dateController.text,
                                                        content:
                                                            contentController
                                                                .text,
                                                        image:
                                                            memoryImageFile));
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
                                              fontSize: 22,
                                              color: AppColors.mintGreen),
                                        ),
                                      ),
                                    )
                                  : Flexible(
                                      child: ListView.builder(
                                          itemCount: memoriesList.length,
                                          itemBuilder: (context, index) {
                                            return Dismissible(
                                                key: UniqueKey(),
                                                direction:
                                                    DismissDirection.endToStart,
                                                background: Container(
                                                  color: Colors.red,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Text(
                                                          'حذف',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: AppColors
                                                                  .white),
                                                        ),
                                                        Icon(
                                                          Icons.delete_outline,
                                                          color:
                                                              AppColors.white,
                                                          size: 35,
                                                        ),
                                                      ]),
                                                ),
                                                onDismissed: (direction) {
                                                  setState(() {
                                                    memoriesList
                                                        .removeAt(index);
                                                  });
                                                },
                                                confirmDismiss:
                                                    (DismissDirection
                                                        direction) async {
                                                  return await showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                          'تأكيد حذف الذكري',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        content: const Text(
                                                          'هل تريد حذف هذه الذكري بالفعل؟',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false),
                                                            child: const Text(
                                                                'إلغاء'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true),
                                                            child: const Text(
                                                                'حذف'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Card(
                                                  shadowColor:
                                                      Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
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
                                                              image:
                                                                  memoriesList[
                                                                          index]
                                                                      .image!)),
                                                      Expanded(
                                                        flex: 3,
                                                        child: ListTile(
                                                          title: Text(
                                                              memoriesList[
                                                                      index]
                                                                  .address!),
                                                          subtitle: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(memoriesList[
                                                                      index]
                                                                  .date!),
                                                              Text(memoriesList[
                                                                      index]
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
            ),
    );
  }
}
