import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../components/text_fields.dart';
import '../../constants/color_constatnts.dart';
import '../../networking/dio/api/dio_client.dart';
import '../../networking/dio/models api/patient_user_api.dart';
import '../../networking/dio/repositories/patient_user_repsitory.dart';

class FamilyAndFriendsScreen extends StatefulWidget {
  const FamilyAndFriendsScreen({super.key});

  @override
  State<FamilyAndFriendsScreen> createState() => _FamilyAndFriendsScreenState();
}

class _FamilyAndFriendsScreenState extends State<FamilyAndFriendsScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  List<dynamic> careGiversList = [];

  var careNameController = TextEditingController();
  var careRelationController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final careNameFocusNode = FocusNode();
  final careRelationFocusNode = FocusNode();

  late Dio dio;
  late DioClient dioClient;
  late PatientUserApi userApi;
  late PatientUserRepository patientUserRepository;

  SimpleFontelicoProgressDialog? prograssDialog;

  bool isLoading = true;

  Response? response;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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

  Future<String> fileToBase64(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();
    final base64 = base64Encode(bytes);
    return base64;
  }

  Future<void> refresh() async {
    getUserFaces();
    setState(() {});
    refreshController.refreshCompleted();
  }

  Future<void> getUserFaces() async {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('currentUserToken');
    List<dynamic> userAllFaces =
        await patientUserRepository.getUserAllFaces(userToken!);

    log(userAllFaces.toString());
    setState(() {
      careGiversList = userAllFaces;
      isLoading = false;
    });
  }

  void addCareGiverStater(String name, String bio) {
    setState(() {
      careGiversList.add(
        {
          "address": "-",
          "bio": bio,
          "contact_id": '-',
          "email": "-",
          "full_name": name,
          "phone": "-",
          "relation": "-",
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getUserFaces();
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

  Future<void> showPrograssDialog() async {
    prograssDialog!
        .show(message: "جاري التحميل...", indicatorColor: AppColors.mintGreen);
  }

  Future<void> hidePrograssDialog() async {
    prograssDialog!.hide();
  }

  ImageProvider base64ImageToNetworkImage(String base64String) {
    Uint8List bytes = base64.decode(base64String);
    return MemoryImage(bytes);
  }

  @override
  Widget build(BuildContext context) {
    dio = Dio();
    dioClient = DioClient(dio);
    userApi = PatientUserApi(dioClient: dioClient);
    patientUserRepository = PatientUserRepository(userApi);
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
                                try {
                                  if (careGiverImageFile != null) {
                                    showPrograssDialog();
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    String? userToken =
                                        prefs.getString('currentUserToken');
                                    String image = await fileToBase64(
                                        careGiverImageFile!.file.path
                                            .toString());

                                    await patientUserRepository
                                        .postUserNewFaceRequest(
                                            careNameController.value.text,
                                            careRelationController.value.text,
                                            image,
                                            userToken!);

                                    await refresh();

                                    await hidePrograssDialog();

                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'لا يمكن إضافة شخص بدون صورة !',
                                        backgroundColor: AppColors.mintGreen);
                                  }
                                } catch (e) {
                                  hidePrograssDialog();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            'حدث خطأ غير متوقع يرجي إعادة المحاولة')),
                                  );
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
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.mintGreen,
                backgroundColor: AppColors.white,
              ))
            : careGiversList.isEmpty
                ? const Center(
                    child: Text(
                      'لم يتم إضافة اي اشخاص بعد',
                      style:
                          TextStyle(fontSize: 22, color: AppColors.mintGreen),
                    ),
                  )
                : SmartRefresher(
                    controller: refreshController,
                    enablePullDown: true,
                    onRefresh: refresh,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: careGiversList.length,
                        itemBuilder: (context, index) {
                          //String base64String =  careGiversList[index]['face_url'];
                          //ImageProvider networkImage = base64ImageToNetworkImage(base64String);
                          return Card(
                            shadowColor: AppColors.mintGreen,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: const Color.fromARGB(255, 244, 244, 244),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                      width: 100,
                                      height: 100,
                                      image: NetworkImage(careGiversList[index]['face_url'])),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    careGiversList[index]['name'],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    careGiversList[index]['bio'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.mintGreen,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ));
  }
}
