import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:memory_mate/constants/color_constatnts.dart';
import 'package:page_transition/page_transition.dart';

import 'add_field.dart';
import 'info_appointment.dart';
import 'create_appointment.dart';

class medical_appointment extends StatefulWidget {
  const medical_appointment({super.key});

  @override
  State<medical_appointment> createState() => _medical_appointmentState();
}

class _medical_appointmentState extends State<medical_appointment> {
  @override
  Widget build(BuildContext context) {
    List<String> medicineName = [
      "antibiotic",
      "atenoretic",
      "panadol",
      "ketofan",
      "spectrum",
      "kometrix",
    ];
    Color swipeColor = Color.fromARGB(255, 236, 236, 236);
    int num_of_medicine = medicineName.length;
    final items = List<Widget>.generate(
        6, (i) => appointment(medicineName: medicineName[i]));
    return Scaffold(
      appBar: AppBar(
        leading: Icon(null),
        elevation: 0,
        actions: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
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
        child: Icon(
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
          search(),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: medicineName.length == 0
                ? Image.asset('assets/images/pictures/Group 218.png')
                : ListView.separated(
                    itemBuilder: ((context, index) => Dismissible(
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              setState(() {
                                items.removeAt(index);
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
                                      child: const info_appointment()),
                                );
                                bool edit = true;
                              });
                            }
                          },
                          background: Container(
                            color: swipeColor,
                          ),
                          key: ObjectKey(items[num_of_medicine - 1]),
                          child: appointment(medicineName: medicineName[index]),
                        )),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: medicineName.length,
                  ),
          ),
        ],
      ),
    );
  }
}
