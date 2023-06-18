import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:memory_mate/controllers/providers/medicine_provider.dart';
import 'package:memory_mate/controllers/providers/second_user_location.dart';
import 'package:memory_mate/views/splash%20and%20onboarding/splash_screen.dart';
import 'package:provider/provider.dart';
import 'models/board_adapter.dart';
import 'package:provider/provider.dart' as provider;

List<CameraDescription> cameras = [];
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.mintGreen, // navigation bar color
    statusBarColor: AppColors.white,
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    systemNavigationBarDividerColor:
        AppColors.mintGreen, //Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await Hive.initFlutter();
  Hive.registerAdapter(BoardAdapter());

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    if (kDebugMode) {
      print('Error in fetching the cameras: $e');
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MedicineListModel medicineListModel = MedicineListModel();
  final SecondUserLocationProvider secondUserLocationProvider =
      SecondUserLocationProvider();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        provider.ChangeNotifierProvider.value(value: medicineListModel),
        provider.ChangeNotifierProvider.value(
            value: secondUserLocationProvider),
      ],
      child: ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'رفيق الذاكرة',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar', 'AE'),
            Locale("en", "US"),
            Locale("en", "UK"),
          ],
          theme: ThemeData(
            fontFamily: 'Boutros',
            primarySwatch: mintGreenMaterial,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

Map<int, Color> mainColor = {
  50: const Color.fromRGBO(33, 159, 148, .1),
  100: const Color.fromRGBO(33, 159, 148, .2),
  200: const Color.fromRGBO(33, 159, 148, .3),
  300: const Color.fromRGBO(33, 159, 148, .4),
  400: const Color.fromRGBO(33, 159, 148, .5),
  500: const Color.fromRGBO(33, 159, 148, .6),
  600: const Color.fromRGBO(33, 159, 148, .7),
  700: const Color.fromRGBO(33, 159, 148, .8),
  800: const Color.fromRGBO(33, 159, 148, .9),
  900: const Color.fromRGBO(33, 159, 148, 1),
};
MaterialColor mintGreenMaterial = MaterialColor(0xFF219F94, mainColor);
