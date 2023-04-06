
import 'package:flutter/material.dart';

class AddCareGiver {
  String? careName;
  String? careRelation;
  ImageProvider? careImage;  

  AddCareGiver({this.careName, this.careRelation, this.careImage});

  AddCareGiver.fromJson(Map<String, dynamic> json) {
    careName = json['careName'];
    careRelation = json['careRelation'];
    careImage = json['careImage'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['careName'] = careName;
    data['careRelation'] = careRelation;
    data['careImage'] = careImage;
    
    return data;
  }
}
