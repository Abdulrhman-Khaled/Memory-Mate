import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memory_mate/views/family%20and%20friends/my_patients_screen.dart';
import 'package:memory_mate/views/profile/profile_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../constants/color_constatnts.dart';
import '../maps and locations/map_view_screen.dart';
import '../splash and onboarding/sign_in_or_register_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:dio/dio.dart';

import '../../networking/dio/api/dio_client.dart';
import '../../networking/dio/models api/patient_user_api.dart';
import '../../networking/dio/repositories/patient_user_repsitory.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class CareGiverHomeScreen extends StatefulWidget {
  const CareGiverHomeScreen({super.key});

  @override
  State<CareGiverHomeScreen> createState() => _CareGiverHomeScreenState();
}

class _CareGiverHomeScreenState extends State<CareGiverHomeScreen> {
  late Dio dio;
  late DioClient dioClient;
  late PatientUserApi userApi;
  late PatientUserRepository patientUserRepository;

  String username = '';

  String imageLink = '';

  bool isLoading = true;

  final GlobalKey<ScaffoldState> key = GlobalKey();

  SimpleFontelicoProgressDialog? prograssDialog;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> refresh() async {
    getUserInfo();
    setState(() {});
    refreshController.refreshCompleted();
  }

  Future<void> showPrograssDialog() async {
    prograssDialog!
        .show(message: "جاري التحميل...", indicatorColor: AppColors.mintGreen);
  }

  Future<void> hidePrograssDialog() async {
    prograssDialog!.hide();
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
    setState(() {
      List<String> firstName = userInformation['name'].trim().split(" ");
      username = firstName[0];

      imageLink = userInformation['avatar'];

      isLoading = false;
    });

    dev.log(userInformation.toString());

    return userInformation;
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
    prograssDialog = SimpleFontelicoProgressDialog(context: context);
  }

  void showAppInfoDialog(PackageInfo packageInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'عن التطبيق',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, color: AppColors.mintGreen),
          ),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('اسم التطبيق: ${packageInfo.appName}'),
                Text('اسم الحزمة: ${packageInfo.packageName}'),
                Text(
                    'الأصدار: ${packageInfo.version}+${packageInfo.buildNumber}'),
                Text('رمز التوقيع: ${packageInfo.buildSignature}'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var randomQuatosList = [
      'نتمني ان يكون كل شئ بخير',
    ];
    final random = Random();
    String element = randomQuatosList[random.nextInt(randomQuatosList.length)];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        key: key,
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 16, 20),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings_outlined,
                        color: AppColors.mintGreen,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'الاعدادات',
                        style: TextStyle(
                            fontSize: 25,
                            color: AppColors.lightBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 0.5,
                thickness: 0.5,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(0, 7, 20, 7),
                  horizontalTitleGap: 0,
                  minLeadingWidth: 35,
                  leading: const Icon(
                    Icons.info_outline,
                    color: AppColors.mintGreen,
                    size: 27,
                  ),
                  title: const Text(
                    'عن التطبيق',
                    style: TextStyle(fontSize: 22, color: AppColors.lightBlack),
                  ),
                  onTap: () async {
                    PackageInfo packageInfo = await PackageInfo.fromPlatform();
                    showAppInfoDialog(packageInfo);
                  },
                ),
              ),
              const Divider(
                height: 0.5,
                thickness: 0.5,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(0, 7, 20, 7),
                  horizontalTitleGap: 0,
                  minLeadingWidth: 35,
                  leading: const Icon(
                    Icons.contact_mail_outlined,
                    color: AppColors.mintGreen,
                    size: 27,
                  ),
                  title: const Text(
                    'التواصل مع المطورين',
                    style: TextStyle(fontSize: 22, color: AppColors.lightBlack),
                  ),
                  onTap: () async {
                    String email = Uri.encodeComponent("bodyono3@gmail.com");
                    String subject = Uri.encodeComponent(
                        "رسالة الي الدعم الفني الخاص بتطبيق Memory Mate");
                    String body = Uri.encodeComponent(
                        "قم باستبدال هذا النص برسالتك وسنقوم بالرد عليك في اسرع وقت");
                    Uri mail =
                        Uri.parse("mailto:$email?subject=$subject&body=$body");
                    if (await launchUrl(mail)) {
                      //email app opened
                    } else {
                      //email app is not opened
                    }
                  },
                ),
              ),
              const Divider(
                height: 0.5,
                thickness: 0.5,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(0, 7, 20, 10),
                      horizontalTitleGap: 0,
                      minLeadingWidth: 35,
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 27,
                      ),
                      title: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(fontSize: 22, color: Colors.red),
                      ),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedIn', false);
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const SignInOrRegister()),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.white,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: height / 6,
                        color: AppColors.white,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                'assets/images/icons/bar_tree.png',
                                height: height / 6,
                              ),
                            ),
                            Align(
                              alignment: const Alignment(0, 0.5),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        key.currentState!.openDrawer(),
                                    icon: const Icon(
                                      Icons.menu,
                                      color: AppColors.mintGreen,
                                      size: 45,
                                    ),
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'مرحبا يا $username',
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: AppColors.lightBlack),
                                      ),
                                      Text(
                                        element,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: AppColors.lightBlack),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(imageLink)),
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: width,
                            decoration: const BoxDecoration(
                                color: AppColors.lightmintGreen,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(60),
                                    topLeft: Radius.circular(60))),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Image(
                                width: 290,
                                image: AssetImage(
                                  'assets/images/icons/main_tree.png',
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 250,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: AppColors.mintGreen,
                                            width: 2,
                                            style: BorderStyle.solid),
                                        backgroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: const MapViewScreen()),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/icons/gps.png',
                                            width: 80,
                                            height: 80,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "الأماكن وتحديدالمواقع",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.lightBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 150,
                                    width: 250,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: AppColors.mintGreen,
                                            width: 2,
                                            style: BorderStyle.solid),
                                        backgroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        /*Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: const OnBoard()),
                                        );*/
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/icons/xray.png',
                                            width: 80,
                                            height: 80,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "التشخيص من خلال الأشعة",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.lightBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 150,
                                    width: 250,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: const BorderSide(
                                            color: AppColors.mintGreen,
                                            width: 2,
                                            style: BorderStyle.solid),
                                        backgroundColor: AppColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: const MyPatientsScreen()),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/pictures/linkedpatient.png',
                                            width: 100,
                                            height: 80,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "المرضي المتصلين بك",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.lightBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: width,
                              height: 80,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.mintGreen,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: const ProfileScreen(),
                                            type: PageTransitionType.fade));
                                  },
                                  icon: Image.asset(
                                    'assets/images/icons/caregiver.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  label: const Text(
                                    'الحساب الشخصي',
                                    style: TextStyle(
                                        color: AppColors.white, fontSize: 25),
                                  ),
                                ),
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
  }
}
