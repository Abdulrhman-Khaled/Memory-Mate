import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/color_constatnts.dart';
import '../../models/onboard_model.dart';
import '../sign in and register/sign_in_or_register_screen.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({key});

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/pictures/picone.png',
      text: "نهتم من خلال البرنامج بتنظيم الحالة الصحية لمرضي الزهايمر كتنظيم موعيد الادوية",
      desc:
          "",
      bg: Colors.white,
      button: Colors.white30,
    ),
    OnboardModel(
      img: 'assets/images/pictures/pictwo.png',
      text: "ونهتم بالحالة النفسية كمشاركة الذكريات والمحادثات والألعاب",
      desc:
          "",
      bg: Colors.white,
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical:40.0),
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                          height: 65.0,
                        ),
                  Image.asset(screens[index].img),

                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Boutros',
                      color: AppColors.mintGreen,
                    ),
                  ),
                  SizedBox(
                          height: 100.0,
                        ),
                  Container(
                    height: 10.0,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 25 : 8,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? AppColors.mintGreen
                                      : AppColors.lightmintGreen,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  
                  InkWell(
                    onTap: () async {
                      print(index);
                      if (index == screens.length - 1) {
                        await _storeOnboardInfo();
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignInOrRegister()));
                      }

                      _pageController.nextPage(
                        duration: Duration(milliseconds: 150),
                        curve: Curves.bounceIn,
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, children: [
                        
                        const Text(
                          "التالي",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: AppColors.mintGreen,
                              ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(
                          Icons.arrow_forward_sharp,
                          color: AppColors.mintGreen,
                        ),
                      ]),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
