import 'package:flutter/material.dart';

class MedItems {
  final String name;
  final String repeat;
  final String time;
  final String count;

  MedItems(this.name, this.repeat, this.time, this.count);
}

class MedicineListModel extends ChangeNotifier {
  final List<MedItems> _medsItems = [];

  List<MedItems> get items => _medsItems;

  void addItem(MedItems item) {
    _medsItems.add(item);
    notifyListeners();
  }
}