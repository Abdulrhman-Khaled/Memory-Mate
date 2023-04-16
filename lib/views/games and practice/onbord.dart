import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/color_constatnts.dart';
import '../../models/onboarding_model.dart';
import 'games_home.dart';



class OnBoard extends StatefulWidget {
  const OnBoard({key});

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardingModel> screens = <OnboardingModel>[
    OnboardingModel(
      img: 'assets/images/pictures/gamingboard.png',
      text: "  مرحبا بك في الجزأ الخاص بالألعاب , سيساعدك هذا الجزأ علي زيادة التركيز وتنشيط الذاكرة",
      desc:" 😊 إبدأ باللعب واستمتع بوقتك",
      bg: AppColors.mintGreen,
      button: Colors.white30,
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

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
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
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                            height: 65.0,
                          ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        screens[index].text,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Boutros',
                          color: AppColors.mintGreen,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          screens[index].desc,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Boutros',
                            color: Color.fromARGB(255, 174, 174, 174),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                            height: 10.0,
                          ),

                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ElevatedButton(
                                   style: ElevatedButton.styleFrom(
                                  minimumSize: Size(120.0, 40.0),
                                  backgroundColor: AppColors.mintGreen,
                                  textStyle: TextStyle(
                                    fontFamily: 'Boutros',
                                    fontSize: 18.0
                                  )
                                ) ,
                                onPressed: (){
                                  Navigator.push(
                                  context,  
                                  PageTransition(
                                  type: PageTransitionType.fade,
                                  child:  gameshome()),);
                                },
                                  child: Text("إبدأ")),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}