import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../components/info_card.dart';
import '../../constants/color_constatnts.dart';
import '../../utils/game_utils.dart';

import 'games_home.dart';


class GameOne extends StatefulWidget {
  const GameOne({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GameOneState createState() => _GameOneState();
}

class _GameOneState extends State<GameOne> {
  //setting text style
  TextStyle whiteText = const TextStyle(color: AppColors.white);
  bool hideTest = false;
  final Game _game = Game();

  //game stats
  int tries = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              " لعبة الذاكرة",
              style: TextStyle(
                fontSize: 40.0,
                fontFamily: 'Boutros',
                fontWeight: FontWeight.bold,
                color: AppColors.mintGreen,
              ),
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              info_card("المحاولات", "$tries" ),
              info_card("النتيجة", "$score"),
            ],
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,

              child: GridView.builder(
                  itemCount: _game.gameImg!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(_game.matchCheck);
                        setState(() {
                          //incrementing the clicks
                          tries++;
                          _game.gameImg![index] = _game.cards_list[index];
                          _game.matchCheck
                              .add({index: _game.cards_list[index]});
                          print(_game.matchCheck.first);
                        });
                        if (_game.matchCheck.length == 2) {
                          if (_game.matchCheck[0].values.first ==
                              _game.matchCheck[1].values.first) {
                            print("true");
                            //incrementing the score
                            score += 100;
                            _game.matchCheck.clear();
                          } else {
                            print("false");

                            Future.delayed(const Duration(milliseconds: 500), () {
                              print(_game.gameColors);
                              setState(() {
                                _game.gameImg![_game.matchCheck[0].keys.first] =
                                    _game.hiddenCardpath;
                                _game.gameImg![_game.matchCheck[1].keys.first] =
                                    _game.hiddenCardpath;
                                
                                _game.matchCheck.clear();
                              });
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.lightmintGreenOp,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(_game.gameImg![index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  })),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mintGreen,
                                textStyle: const TextStyle(
                                  fontFamily: 'Boutros',
                                  fontSize: 18.0
                                )
                              ) ,
                              onPressed: (){
                                if(score >= 800){
                                  showDialog(context: context, builder: (context){
                                   return AlertDialog(
                                   backgroundColor: AppColors.white,
                                   content: 
                                  SizedBox(
                                   height: 280.0,
                                   width: 150.0,
                                   child: Column(
                                     children: [  
                                       const SizedBox(height: 10.0,),
                                       Image.asset("assets/images/icons/trophy.png",
                                       width: 170.0,
                                       height: 170.0,),
                                       const SizedBox(height: 15.0,), 
                                       const Text("لقد فزت",
                                        style: TextStyle(
                                       color:AppColors.mintGreen ,
                                       fontFamily: 'Boutros',
                                       fontSize: 22.0
                                        )
                                       ),                                
                                       const SizedBox(height: 5.0,),

                                       ElevatedButton(
                                       style: ElevatedButton.styleFrom(
                                       backgroundColor: AppColors.mintGreen,
                                       textStyle: const TextStyle(
                                       fontFamily: 'Boutros',
                                       fontSize: 18.0
                                          )
                                        ) ,
                                        onPressed: (){
                                       Navigator.pop(context);},
                                     child: const Icon(Icons.check)),                                                                       
                                     ],  
                                   ),
                                  ),  
                          );
                      });
                }
                              },
                                child: const Icon(Icons.check)),



                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mintGreen,
                                textStyle: const TextStyle(
                                  fontFamily: 'Boutros',
                                  fontSize: 18.0
                                )
                              ) ,
                              onPressed: (){
                                Navigator.push(
                                context,  
                                PageTransition(
                                type: PageTransitionType.fade,
                                child:  const gameshome()),);
                              },
                                child: const Text("عودة")),
                          ],
                        )  
        ],
      ),
    );
  }
}


