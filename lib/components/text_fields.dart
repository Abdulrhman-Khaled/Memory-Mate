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
        String hintText = '',
        Color hintColor = AppColors.lightGrey,
        double hintSize = 20.0,
        int maxLetters = 11,
        bool needMax = false,
        bool needSuffix = false,
        IconData iconLead = Icons.add,
        IconData iconSuffix = Icons.add,
        Color iconColor = AppColors.mintGreen,
        double iconSize = 35.0,
        String labelText = '',
        Color labelColor = AppColors.mintGreen,
        double labelSize = 20.0,
        int inputLength = 8,
        bool isPassword = false,
        int minlines = 1,
        int maxlines = 1,
        Function()? function,
        Function()? onTapFunction,
        Function(String)? onChangeFunction,
        Function()? validateFunction,
        dynamic focusNode,
        bool readOnly = false,
        bool isLength = false,
        bool isMatch = false,
        String passwordNotBigText = 'كلمة المرور يجب ان تساوي 8 رموز علي الأقل',
        String passwordNotMatchText = 'كلمة المرور غير متطابقة',
        String matchPassword = '',
        String thisPasssword = '',
        String validatText = '',
        String helperText = ''}) =>
    SizedBox(
      width: width,
      height: height,
      child: TextFormField(      
        readOnly: readOnly,
        onTap: onTapFunction,
        onChanged: onChangeFunction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatText;
          } else if (isLength == true && value.length < inputLength) {
            return passwordNotBigText;
          } else if (isMatch == true && thisPasssword != matchPassword) {
            return passwordNotMatchText;
          }
          return null;
        },
        focusNode: focusNode,
        keyboardType: textType,
        obscureText: isPassword,
        controller: textFormController,
        cursorColor: AppColors.mintGreen,
        minLines: minlines,
        maxLines: maxlines,
        style: TextStyle(fontSize: textSize, color: textColor),
        maxLength: needMax == true ? maxLetters : null,
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
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
