import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_constatnts.dart';
import '../../models/onboarding_model.dart';
import 'games_home.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardingModel> screens = <OnboardingModel>[
    OnboardingModel(
      img: 'assets/images/pictures/gamingboard.png',
      text:
          "مرحبا بك في الجزء الخاص بالألعاب , سيساعدك هذا الجزء علي زيادة التركيز وتنشيط الذاكرة",
      desc: "😊 إبدأ باللعب واستمتع بوقتك",
      bg: AppColors.mintGreen,
      button: AppColors.lightBlack,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ignore: unused_element
  _storeOnboardInfo() async {
    if (kDebugMode) {
      print("Shared pref called");
    }
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    if (kDebugMode) {
      print(prefs.getInt('onBoard'));
    }
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
          "الألعاب والممارسات",
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/pictures/gamingpic.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        screens[index].text,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Boutros',
                          color: AppColors.mintGreen,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          screens[index].desc,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Boutros',
                            color: AppColors.lightBlack,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(140.0, 40.0),
                                backgroundColor: AppColors.mintGreen,
                                textStyle: const TextStyle(
                                    fontFamily: 'Boutros', fontSize: 18.0)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const gameshome()),
                              );
                            },
                            child: const Text("إبدأ الأن")),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
