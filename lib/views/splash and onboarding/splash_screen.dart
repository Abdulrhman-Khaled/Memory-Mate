import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:page_transition/page_transition.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(milliseconds: 1500),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: const OnBoardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
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
