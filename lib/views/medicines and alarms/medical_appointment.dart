import 'package:flutter/material.dart';

import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controllers/providers/medicine_provider.dart';
import 'add_field.dart';

import 'create_appointment.dart';

// ignore: camel_case_types
class medical_appointment extends StatefulWidget {
  const medical_appointment({super.key});

  @override
  State<medical_appointment> createState() => medical_appointmentState();
}

// ignore: camel_case_types
class medical_appointmentState extends State<medical_appointment> {
  final TextEditingController _searchController = TextEditingController();
  late List<MedItems> _filteredItems;

  @override
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final medicineListModel = context.watch<MedicineListModel>();
    _filteredItems = medicineListModel.items;
  }

  @override
  Widget build(BuildContext context) {
    final medicineListModel = context.watch<MedicineListModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'مواعيد الأدوية ',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mintGreen,
        child: const Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () async {
          final newItems = await Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: const createAppointment()));
          if (newItems != null) {
            medicineListModel.addItem(newItems);
          }
        },
      ),
      backgroundColor: AppColors.mintGreen,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() {
                    _filteredItems = medicineListModel.items
                        .where((item) => item.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  }),
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.mintGreen,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      focusedBorder: OutlineInputBorder(
                          gapPadding: 4,
                          borderSide: const BorderSide(
                            color: AppColors.mintGreen,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      suffixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.only(top: 20),
                      hintText: 'ابحث عن ميعاد دواء معين',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: const TextStyle(
                        fontSize: 20,
                      )),
                  cursorRadius: const Radius.circular(50),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: _filteredItems.isEmpty
                  ? Image.asset(
                      'assets/images/pictures/Group 218.png',
                      width: 300,
                    )
                  : ListView.separated(
                      itemBuilder: ((context, index) => Dismissible(
                            direction: DismissDirection.startToEnd,
                            confirmDismiss: (direction) async {
                              setState(() {
                                _filteredItems.removeAt(index);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('تم حذف ميعاد الدواء'),
                                ));
                              });
                              return null;
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'مرر لحذف الميعاد',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            key: ObjectKey(
                                _filteredItems[_filteredItems.length - 1]),
                            child: appointment(
                              medicineName:
                                  _filteredItems[index].name.toString(),
                              medicineDate:
                                  _filteredItems[index].repeat.toString(),
                              medicinetime:
                                  _filteredItems[index].time.toString(),
                              medicineRepeat:
                                  '${_filteredItems[index].count} مرات',
                            ),
                          )),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: _filteredItems.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
