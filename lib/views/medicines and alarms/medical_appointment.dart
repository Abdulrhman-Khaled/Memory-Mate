import 'package:flutter/material.dart';

import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:page_transition/page_transition.dart';

import 'add_field.dart';
import 'info_appointment.dart';
import 'create_appointment.dart';

// ignore: camel_case_types
class medical_appointment extends StatefulWidget {
  const medical_appointment({super.key});

  @override
  State<medical_appointment> createState() => _medical_appointmentState();
}

// ignore: camel_case_types
class _medical_appointmentState extends State<medical_appointment> {
  final List<Map<String, dynamic>> _allUsers = [
    {
      "medicineName": "antibiotic",
      "medicineDate": "يتكرر في ايام السبت والاحد والاثنين والثلاثاء",
      "medicinetime": '12:00'
    },
    {
      "medicineName": "atenoretic",
      "medicineDate": "يتكرر في ايام السبت والاحد والاثنين والثلاثاء",
      "medicinetime": '12:00'
    },
    {
      "medicineName": "panadol",
      "medicineDate": "يتكرر في ايام السبت والاحد والاثنين والثلاثاء",
      "medicinetime": '12:00'
    },
    {
      "medicineName": "ketofan",
      "medicineDate": "يتكرر في ايام السبت والاحد والاثنين والثلاثاء",
      "medicinetime": '12:00'
    },
    {
      "medicineName": "spectrum",
      "medicineDate": "يتكرر في ايام السبت والاحد والاثنين والثلاثاء",
      "medicinetime": '12:00'
    },
    {
      "medicineName": "kometrix",
      "medicineDate": "يتكرر في ايام السبت والاحد والاثنين والثلاثاء",
      "medicinetime": '12:00'
    },
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) => user["medicineName"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    TextEditingController myController = TextEditingController();
    // ignore: unused_local_variable
    Color swipeColor;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(null),
        elevation: 0,
        actions: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    'مواعيد الادويه ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mintGreen,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: const createAppointment()));
        },
      ),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 30,
            color: AppColors.mintGreen,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 30,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 37,
              child: TextField(
                onChanged: (value) => _runFilter(value),
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
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.sort_sharp),
                    ),
                    contentPadding: const EdgeInsets.only(top: 15),
                    hintText: 'ابحث عن ميعاد معين',
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: const TextStyle(
                      fontSize: 20,
                    )),
                cursorHeight: 20,
                cursorRadius: const Radius.circular(50),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: _foundUsers.isEmpty
                ? Image.asset('assets/images/pictures/Group 218.png')
                : ListView.separated(
                    itemBuilder: ((context, index) => Dismissible(
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              setState(() {
                                _foundUsers.removeAt(index);
                                swipeColor = AppColors.mintGreen;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('appointment deleted')));
                              });
                            } else {
                              setState(() {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: info_appointment()),
                                );
                                swipeColor = Colors.black;
                              });
                            }
                            return null;
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20.0, left: 10),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    'مرر لالغاء الميعاد',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          secondaryBackground: Container(
                            color: AppColors.mintGreen,
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    'مرر لتعديل الميعاد',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          key: ObjectKey(_foundUsers[_foundUsers.length - 1]),
                          child: appointment(
                            medicineName:
                                _foundUsers[index]["medicineName"].toString(),
                            medicineDate:
                                _foundUsers[index]["medicineDate"].toString(),
                            medicinetime:
                                _foundUsers[index]["medicinetime"].toString(),
                          ),
                        )),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: _foundUsers.length,
                  ),
          ),
        ],
      ),
    );
  }
}
