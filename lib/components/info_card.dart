import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_constatnts.dart';


// ignore: non_constant_identifier_names
Widget info_card(String title, String info) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(26.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
      decoration: BoxDecoration(
      color: AppColors.mintGreen,
      borderRadius: BorderRadius.circular(25.0),
      
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18.0,
              fontFamily: 'Boutros',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6.0,
          ),
          Text(
            info,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 23.0, 
              fontFamily: 'Boutros',
              fontWeight: FontWeight.bold
              ),
          ),
        ],
      ),
    ),
  );
}
