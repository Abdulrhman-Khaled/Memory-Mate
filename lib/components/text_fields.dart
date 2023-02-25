import 'package:flutter/material.dart';
import 'package:memory_mate/constants/color_constatnts.dart';

Widget textField(
        {double width = 250.0,
        double height = 90.0,
        TextInputType textType = TextInputType.emailAddress,
        TextEditingController? textFormController,
        Color fillColor = AppColors.lightmintGreenOp,
        double textSize = 20.0,
        Color textColor = AppColors.lightBlack,
        String hintText = 'hint',
        Color hintColor = AppColors.lightGrey,
        double hintSize = 20.0,
        int maxLetters = 80,
        bool needMax = false,
        bool needSuffix = false,
        IconData iconLead = Icons.add,
        IconData iconSuffix = Icons.add,
        Color iconColor = AppColors.mintGreen,
        double iconSize = 35.0,
        String labelText = 'label',
        Color labelColor = AppColors.mintGreen,
        double labelSize = 20.0,
        bool isPassword = false,
        Function()? function,
        Function()? onTapFunction,
        Function(String)? onChangeFunction,
        dynamic focusNode,
        String validatText2 = '',
        String validatText = 'Error',
        String helperText = ''}) =>
    SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        onTap: onTapFunction,
        onChanged: onChangeFunction,
        validator:(value) {
          if (value == null || value.isEmpty) {
                return validatText;
              }
              return validatText2;
        },
        focusNode: focusNode,
        keyboardType: textType,
        obscureText: isPassword,
        controller: textFormController,
        cursorColor: AppColors.mintGreen,
        style: TextStyle(fontSize: textSize, color: textColor),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: AppColors.lightGrey,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: AppColors.mintGreen,
              width: 1.0,
            ),
          ),
          suffixIcon: needSuffix == true
              ? IconButton(
                  icon: Icon(
                    iconSuffix,
                    color: iconColor,
                    size: 30,
                  ),
                  onPressed: function,
                )
              : null,
          filled: true,
          fillColor: fillColor,
          prefixIcon: Icon(
            iconLead,
            color: iconColor,
            size: iconSize,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: hintSize,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelColor,
            fontSize: labelSize,
          ),
          helperText: helperText,
        ),
      ),
    );
