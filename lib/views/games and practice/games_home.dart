import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import '../../constants/color_constatnts.dart';
import 'game_two_home.dart';
import 'game_one_home.dart';

// ignore: camel_case_types
class gameshome extends StatelessWidget {
  const gameshome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mintGreen,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        centerTitle: true,
        title: const Text(
          'قائمة الألعاب',
          style: TextStyle(fontSize: 25, color: AppColors.white),
        ),
      ),
      body: Stack(children: [
        const Align(
          alignment: Alignment.topRight,
          child: Image(
              width: 250,
              image: AssetImage(
                'assets/images/icons/bar_tree.png',
              )),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 220.0,
                  height: 220.0,
                  decoration: const BoxDecoration(
                      color: AppColors.lightmintGreen,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(children: [
                    const SizedBox(height: 10),
                    Image.asset(
                      'assets/images/icons/block.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "لعبة الذاكرة",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(120.0, 40.0),
                            backgroundColor: AppColors.mintGreen,
                            textStyle: const TextStyle(
                                fontFamily: 'Boutros', fontSize: 18.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const GameOne()),
                          );
                        },
                        child: const Text("البدأ",
                            style: TextStyle(
                                fontFamily: 'Boutros', fontSize: 20.0))),
                  ])),
              const SizedBox(height: 25),
              Container(
                width: 220.0,
                height: 220.0,
                decoration: const BoxDecoration(
                    color: AppColors.lightmintGreen,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/icons/number.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "2048 تسلسل الارقام",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(120.0, 40.0),
                          backgroundColor: AppColors.mintGreen,
                          textStyle: const TextStyle(
                              fontFamily: 'Boutros', fontSize: 18.0)),
                      onPressed: () {
                        var gameTwo = const GameTwo();
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade, child: gameTwo),
                        );
                      },
                      child: const Text("البدأ")),
                ]),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
