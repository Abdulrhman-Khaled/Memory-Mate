
import 'package:flutter/material.dart';

class Memories {
  String? address;
  String? date;
  String? content;
  ImageProvider? image;  

  Memories({this.address, this.date, this.content, this.image});

  Memories.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    date = json['date'];
    content = json['content'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['date'] = date;
    data['content'] = content;
    data['image'] = image;
    return data;
  }
}
