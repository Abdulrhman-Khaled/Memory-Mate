import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import '../../constants/color_constatnts.dart';
import 'game_two_home.dart';
import 'game_one_home.dart';

class gameshome extends StatelessWidget {
  const gameshome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: Image.asset(
              'assets/images/icons/bar_tree.png',
              height: 150.0,
              ),
            ),
          Expanded(
            child: Stack(
              children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Align(
                        alignment: Alignment.center,
                        child: 
                            Container(
                              width: 220.0,
                              height: 220.0,
                              decoration: const BoxDecoration(
                              color: AppColors.lightmintGreen,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                              child:Column(
                                children: [
                                SizedBox(height: 10),  
                                Image.asset('assets/images/icons/block.png',
                                 width: 100.0,
                                 height: 100.0,),
                                 const SizedBox(height: 15),
                                Text("لعبة الذاكرة",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
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
                                child:  GameOne()),);
                              },
                                child: Text("البدأ",
                                style: TextStyle(
                                  fontFamily: 'Boutros',
                                  fontSize: 20.0
                                ))),
                    ]  )
                            ),   
                      ),
                    const SizedBox(height: 20),
                      Container(
                        width: 220.0,
                        height: 220.0,
                        decoration: const BoxDecoration(
                          color: AppColors.lightmintGreen,
                          borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                          child: Column(
                                children: [
                                SizedBox(height: 10),  
                                Image.asset('assets/images/icons/number.png',
                                 width: 100.0,
                                 height: 100.0,),
                                 const SizedBox(height: 10),
                                Text(" 2024 تسلسل الارقام",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.white,
                                  ),),
                            const SizedBox(height: 10),
                                ElevatedButton(
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
                                child:  GameTwo()),);
                              },
                                child: Text("البدأ")),
                    ]  ) ,
                      ),
                    const SizedBox(height: 30),  
                    ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(130.0, 40.0),
                                backgroundColor: AppColors.mintGreen,
                                textStyle: TextStyle(
                                  fontFamily: 'Boutros',
                                  fontSize: 18.0
                                )
                              ) ,
                              onPressed: (){
                                //Navigator.push(
                                //context,  
                                //PageTransition(
                                //type: PageTransitionType.fade,
                                //child:  MyWidget()),);
                              },
                                child: Text("الصفحة الرئيسية")),        
                  ],
                )),
              ],
            ))
        ],
      ),
    );
  }
}