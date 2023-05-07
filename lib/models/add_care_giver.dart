import 'package:flutter/material.dart';

class AddCareGiver {
  String? careName;
  String? careRelation;
  
  ImageProvider? careImage;

  AddCareGiver({this.careName, this.careRelation, this.careImage});

  factory AddCareGiver.fromJson(Map<String, dynamic> json) {
    return AddCareGiver(
      careName: json['full_name'],
      careRelation: json['bio'],
      careImage: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['careName'] = careName;
    data['careRelation'] = careRelation;
    data['careImage'] = careImage;

    return data;
  }
}
