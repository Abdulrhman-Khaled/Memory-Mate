import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:memory_mate/views/home%20pages/caregiver_home_screen.dart';
import 'package:memory_mate/views/home%20pages/patient_home_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    Timer(const Duration(milliseconds: 1500), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userType = prefs.getString('currentUserType');

      if (_isLoggedIn == true) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: userType == 'PATIENT'
                    ? const PatientHomeScreen()
                    : const CareGiverHomeScreen()));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: const OnBoardingScreen()));
      }
    });
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    checkLoginStatus();
    return Container(
      color: AppColors.lightmintGreen,
      child: Image.asset(
        'assets/images/logos/logo.png',
        height: 90.0,
        width: 90.0,
      ),
    );
  }
}
