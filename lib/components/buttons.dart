import 'package:flutter/material.dart';
import 'package:memory_mate/constants/color_constatnts.dart';

Widget filledButton(
        {double width = 200.0,
        double height = 40.0,
        Color buttonColor = AppColors.mintGreen,
        Color buttonTextColor = AppColors.white,
        double textSize = 20.0,
        String buttonText = "button text",
        Function()? function}) =>
    SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: function,
        child: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor, fontSize: textSize),
        ),
      ),
    );

Widget filledIconButton(
        {double width = 200.0,
        double height = 40.0,
        Color buttonColor = AppColors.mintGreen,
        Color buttonTextColor = AppColors.white,
        double textSize = 20.0,
        String buttonText = "button text",
        Function()? function,
        double iconSize = 24.0,
        IconData buttonIcon = Icons.add}) =>
    SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: function,
        icon: Icon(
          buttonIcon,
          size: iconSize,
          color: buttonTextColor,
        ),
        label: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor, fontSize: textSize),
        ),
      ),
    );

Widget outlineButton(
        {double width = 200.0,
        double height = 40.0,
        Color buttonColor = AppColors.mintGreen,
        Color buttonTextColor = AppColors.mintGreen,
        double textSize = 20.0,
        String buttonText = "button text",
        Function()? function}) =>
    SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            side: BorderSide(
                color: buttonColor, width: 1.5, style: BorderStyle.solid)),
        onPressed: function,
        child: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor, fontSize: textSize),
        ),
      ),
    );

Widget outlineIconButton(
        {double width = 200.0,
        double height = 40.0,
        Color buttonColor = AppColors.mintGreen,
        Color buttonTextColor = AppColors.mintGreen,
        double textSize = 20.0,
        String buttonText = "button text",
        Function()? function,
        double iconSize = 24.0,
        IconData buttonIcon = Icons.add}) =>
    SizedBox(
      width: width,
      height: height,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            side: BorderSide(
                color: buttonColor, width: 1.5, style: BorderStyle.solid)),
        onPressed: function,
        icon: Icon(
          buttonIcon,
          size: iconSize,
          color: buttonTextColor,
        ),
        label: Text(
          buttonText,
          style: TextStyle(color: buttonTextColor, fontSize: textSize),
        ),
      ),
    );