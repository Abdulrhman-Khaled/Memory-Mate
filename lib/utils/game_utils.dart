import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  
  final String hiddenCardpath = "assets/images/icons/question-mark.png";
  List<String> cards_list = [
    "assets/images/icons/record.png",
    "assets/images/icons/traingle.png",
    "assets/images/icons/record.png",
    "assets/images/icons/mountain.png",
    "assets/images/icons/paper.png",
    "assets/images/icons/traingle.png",
    "assets/images/icons/humanoid.png",
    "assets/images/icons/paper.png",
    "assets/images/icons/mountain.png",
    "assets/images/icons/sun.png",
    "assets/images/icons/humanoid.png",
    "assets/images/icons/volleyball.png",
    "assets/images/icons/magic-ball.png",
    "assets/images/icons/volleyball.png",
    "assets/images/icons/magic-ball.png",
    "assets/images/icons/sun.png",
  ];
  final int cardCount = 16;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
