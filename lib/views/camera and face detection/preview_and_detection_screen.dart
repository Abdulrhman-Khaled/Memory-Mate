import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memory_mate/components/buttons.dart';
import 'package:memory_mate/constants/color_constatnts.dart';


class PreviewAndDetectionScreen extends StatelessWidget {
  final File imageFile; 

  const PreviewAndDetectionScreen({
    super.key,
    required this.imageFile, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(
          color: AppColors.mintGreen,
        ),
        centerTitle: true,
        title: const Text(
          'عرض الصورة',
          style: TextStyle(fontSize: 25, color: AppColors.mintGreen),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(
            imageFile,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: filledIconButton(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    buttonText: 'تحديد\nالشخص',
                    buttonColor: AppColors.mintGreen,
                    iconSize: 40,
                    buttonIcon: Icons.person_search_outlined,
                    function: () {
                      // detection code
                    })),
          ),
        ],
      ),
    );
  }
}
