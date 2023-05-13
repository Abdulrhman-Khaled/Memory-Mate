import 'dart:developer' as dev;
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:memory_mate/views/family%20and%20friends/family_and_friends_screen.dart';
import 'package:memory_mate/views/home%20pages/drawer%20pages/link_with_casregiver_screen.dart';
import 'package:memory_mate/views/maps%20and%20locations/map_view_screen.dart';
import 'package:memory_mate/views/profile/who_i_am_screen.dart';
import 'package:memory_mate/views/splash%20and%20onboarding/sign_in_or_register_screen.dart';
import 'package:memory_mate/views/todo%20and%20mission/todo.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../networking/dio/api/dio_client.dart';
import '../../networking/dio/models api/patient_user_api.dart';
import '../../networking/dio/repositories/patient_user_repsitory.dart';
import '../camera and face detection/camera_and_face_detection.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:url_launcher/url_launcher.dart';
import '../games and practice/onbord.dart';
import '../medicines and alarms/medical_appointment.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  late Dio dio;
  late DioClient dioClient;
  late PatientUserApi userApi;
  late PatientUserRepository patientUserRepository;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

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
  void initState() {
    super.initState();
    getUserInfo();
    prograssDialog = SimpleFontelicoProgressDialog(context: context);
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('launch_background');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    scheduleNotifications();
  }

  void scheduleNotifications() async {
    var randomQuatosList = [
      'انا تطبيق رفيق الذاكرة اود ان اطمئن ان كل شئ بخير واريد اخبارك ان الذكريات هي اليوميات المميزة التي نتذكرها مدي الحياة، قم بتدوين ذكرياتك مع عائلتك واصدقائك واحتفظ بها',
      'انا تطبيق رفيق الذاكرة اود ان اطمئن ان كل شئ علي ما يرام ونصيحتي لك هي الا تدع يومك يمر عبثا ، نشط ذاكرتك بالممارسات اليومية ،دون مهامك وابدأ في تنفيذها الآن، نتمني لك يوماً سعيداً',
      'انا تطبيق رفيق الذاكرة اود ان اطمئن عليك وارجو ان تحافظ علي صحتك وتتناول ادويتك في مواعيدها؛ هناك الكثير من الاشخاص الذين يهمهم امرك وصحتك، دمت بخير وسعادة',
    ];
    final random = Random();
    String element = randomQuatosList[random.nextInt(randomQuatosList.length)];

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id', 'channel_name',
        channelDescription: 'channel_description',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker');

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'تطبيق رفيق الذاكرة',
        element,
        RepeatInterval.hourly,
        platformChannelSpecifics);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                height: 1,
                thickness: 1,
                color: AppColors.mintGreen,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(0, 7, 20, 7),
                  horizontalTitleGap: 0,
                  minLeadingWidth: 35,
                  leading: const Icon(
                    Icons.link_outlined,
                    color: AppColors.mintGreen,
                    size: 27,
                  ),
                  title: const Text(
                    'الربط مع مقدم رعاية',
                    style: TextStyle(fontSize: 22, color: AppColors.lightBlack),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: const LinkWithCaregiverScreen()),
                    );
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
                                        'مرحباً يا $username',
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: AppColors.lightBlack),
                                      ),
                                      const Text(
                                        'نتمني ان يكون كل شئ بخير',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
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
                      height: 15,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: width,
                            margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                            decoration: const BoxDecoration(
                                color: AppColors.lightmintGreen,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(60))),
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
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 130,
                                      width: 150,
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
                                              width: 60,
                                              height: 60,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "الأماكن وتحديد\nالمواقع",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: AppColors.lightBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      height: 130,
                                      width: 150,
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
                                                child:
                                                    const CameraAndFaceDetectionScreen()),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/icons/camera.png',
                                              width: 60,
                                              height: 60,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "الكاميرا",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: AppColors.lightBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 130,
                                      width: 150,
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
                                                child:
                                                    const medical_appointment()),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/icons/syringe.png',
                                              width: 60,
                                              height: 60,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "الأدوية",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: AppColors.lightBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      height: 130,
                                      width: 150,
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
                                                child:
                                                    const FamilyAndFriendsScreen()),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/icons/family.png',
                                              width: 60,
                                              height: 60,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "العائلة والاصدقاء",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: AppColors.lightBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 130,
                                      width: 150,
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
                                                child: const OnBoard()),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/icons/mental_health.png',
                                              width: 60,
                                              height: 60,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "الألعاب والممارسات",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: AppColors.lightBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      height: 130,
                                      width: 150,
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
                                                child: const Todo()),
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/icons/todo.png',
                                              width: 60,
                                              height: 60,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "المهام اليومية",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: AppColors.lightBlack),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                                            child: const WhoIAmScreen(),
                                            type: PageTransitionType.fade));
                                  },
                                  icon: Image.asset(
                                    'assets/images/icons/who.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  label: const Text(
                                    'من تكون ؟',
                                    style: TextStyle(
                                        color: AppColors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                height: 100,
                                width: width - 65,
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(170, 158, 158, 158),
                                        spreadRadius: 0.2,
                                        blurRadius: 20,
                                        blurStyle: BlurStyle.normal,
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                    color: AppColors.mintGreen,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                child: Center(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TypewriterAnimatedText(
                                          'داوم علي انشطتك اليومية، تناول ادويتك في مواعيدها، تواصل مع عائلتك؛ هذا قد يجعل حياتك افضل بكثير 😊',
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              color: AppColors.white),
                                          speed:
                                              const Duration(milliseconds: 70),
                                        ),
                                      ],
                                      totalRepeatCount: 1,
                                      displayFullTextOnTap: false,
                                      stopPauseOnTap: false,
                                    ),
                                  ),
                                )),
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
