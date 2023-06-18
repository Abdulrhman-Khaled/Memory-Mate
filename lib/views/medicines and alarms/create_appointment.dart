import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../components/buttons.dart';
import '../../constants/color_constatnts.dart';
import '../../controllers/providers/medicine_provider.dart';
import 'add_field.dart';

// ignore: camel_case_types, must_be_immutable
class createAppointment extends StatefulWidget {
  const createAppointment({super.key});

  @override
  State<createAppointment> createState() => _createAppointmentState();
}

// ignore: camel_case_types
class _createAppointmentState extends State<createAppointment> {
  final nameController = TextEditingController();
  final timeController = TextEditingController();

  String _selectedOptionRebeat = 'تكرار الدواء ';

  MedicineListModel medAdder = MedicineListModel();

  DateTime? alarmDate;
  int? hourPicker;
  int? minPicker;

  int _selectedOptionIndex = 0;

  int count = 1;

  FlutterTts flutterTts = FlutterTts();

  bool _isDailySelected = true;

  List<String> _selectedOptions = ['يومياً'];

  List<String> medDaysList = [];

  List<String> week = [
    "السبت",
    "الأحد",
    "الأثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
  ];
  final List<String> rebeat = [
    "مرة",
    "مرتين",
    "ثلاث مرات",
    "اربع مرات",
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _selectedOptions = List<String>.from(week);
  }

  dynamic _speak() async {
    if (nameController.value.text.isNotEmpty) {
      await flutterTts.speak(nameController.value.text);
    } else {
      Fluttertoast.showToast(
          msg: 'رجا ء ادخال اسم دواء صالح',
          backgroundColor: AppColors.mintGreen);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      confirmText: "تعيين",
      cancelText: "إلغاء",
      initialEntryMode: TimePickerEntryMode.dialOnly,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      DateTime now = DateTime.now();
      DateTime date = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      setState(() {
        FocusManager.instance.primaryFocus?.unfocus();
        hourPicker = pickedTime.hour;
        minPicker = pickedTime.minute;
        timeController.text = pickedTime.format(context).toString();
        alarmDate = date;
      });
    }
  }

  List<String> removeValue(List<String> daysList) {
    String valueToRemove = 'يومياً';
    daysList.removeWhere((element) => element == valueToRemove);
    return daysList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mintGreen,
        appBar: AppBar(
          backgroundColor: AppColors.mintGreen,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            'إنشاء ميعاد دواء جديد',
            style: TextStyle(fontSize: 25, color: AppColors.white),
          ),
        ),
        body: Column(children: [
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Image.asset('assets/images/pictures/todo.png'),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: AppColors.white,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(221, 245, 244, 244)),
                          child: addfield(
                              hint: 'اسم الدواء',
                              icon: Icons.medication_outlined,
                              controller: nameController)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(221, 245, 244, 244)),
                          child: InkWell(
                            onTap: () => _speak(),
                            child: addfield(
                                hint: 'نطق الدواء تلقائياً',
                                enableEdit: false,
                                icon: Icons.volume_up_outlined,
                                sufIcon: Icons.play_circle_outline),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(221, 245, 244, 244)),
                          child: addfield(
                              hint: "تحديد الميعاد",
                              icon: Icons.alarm_add_outlined,
                              controller: timeController,
                              enableEdit: false),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Center(
                                        child:
                                            Text('اختر عدد مرات تكرار الدواء'),
                                      ),
                                      content: StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return SingleChildScrollView(
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: List<Widget>.generate(
                                                  rebeat.length,
                                                  (index) => RadioListTile(
                                                      title:
                                                          Text(rebeat[index]),
                                                      value: index,
                                                      groupValue:
                                                          _selectedOptionIndex,
                                                      onChanged: (int? value) {
                                                        setState(() =>
                                                            _selectedOptionIndex =
                                                                value!);
                                                      }),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('الغاء'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            setState(() {
                                              _selectedOptionRebeat =
                                                  rebeat[_selectedOptionIndex];
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('حسناً'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  AppColors.mintGreen,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                elevation: MaterialStateProperty.all<double>(
                                  0.0,
                                ),
                              ),
                              child: SizedBox(
                                height: 75,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      _selectedOptionRebeat,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 1.5,
                                      color: AppColors.white,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.repeat_outlined,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Center(
                                          child:
                                              Text('اختر ايام تكرار الدواء')),
                                      content: StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CheckboxListTile(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 50),
                                                  title: const Text(
                                                    'يومياً',
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  value: _isDailySelected,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      _isDailySelected = value!;
                                                      _selectedOptions =
                                                          _isDailySelected
                                                              ? ['يومياً']
                                                              : List<String>.from(
                                                                  week);
                                                    });
                                                  },
                                                ),
                                                const Divider(),
                                                ...week.map((option) =>
                                                    CheckboxListTile(
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 50),
                                                      title: Text(
                                                        option,
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                      value: _selectedOptions
                                                          .contains(option),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          if (value!) {
                                                            _selectedOptions
                                                                .add(option);
                                                          } else {
                                                            _selectedOptions
                                                                .remove(option);
                                                          }
                                                          _isDailySelected =
                                                              _selectedOptions
                                                                          .length ==
                                                                      1 &&
                                                                  _selectedOptions[
                                                                          0] ==
                                                                      'يومياً';
                                                        });
                                                      },
                                                    )),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('الغاء'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            if (_isDailySelected == false) {
                                              setState(() {
                                                _selectedOptions = removeValue(
                                                    _selectedOptions);
                                                setState(() {
                                                  medDaysList =
                                                      _selectedOptions;
                                                });
                                              });
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('حسناً'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  AppColors.mintGreen,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                elevation: MaterialStateProperty.all<double>(
                                  0.0,
                                ),
                              ),
                              child: SizedBox(
                                height: 75,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'ايام الدواء',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      width: 1.5,
                                      color: AppColors.white,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.edit_calendar_outlined,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: outlineButton(
                              height: 50,
                              hoverColor: Colors.red,
                              buttonText: 'الغاء',
                              buttonColor: Colors.red,
                              buttonTextColor: Colors.red,
                              function: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: outlineButton(
                                height: 50,
                                buttonText: 'إنشاء',
                                function: () async {
                                  if (nameController.value.text.isNotEmpty &&
                                      timeController.value.text.isNotEmpty) {
                                    FlutterAlarmClock.createAlarm(
                                        hourPicker!, minPicker!);

                                    String rebeatCounts =
                                        rebeat[_selectedOptionIndex];
                                    if (rebeatCounts == 'مرة') {
                                      setState(() {
                                        count = 1;
                                      });
                                    } else if (rebeatCounts == 'مرتين') {
                                      setState(() {
                                        count = 2;
                                      });
                                    } else if (rebeatCounts == 'ثلاث مرات') {
                                      setState(() {
                                        count = 3;
                                      });
                                    } else if (rebeatCounts == 'اربع مرات') {
                                      setState(() {
                                        count = 4;
                                      });
                                    }

                                    if (_isDailySelected) {
                                      setState(() {
                                        medDaysList = ['يومياً'];
                                      });
                                    } else {
                                      setState(() {
                                        medDaysList = medDaysList;
                                      });
                                    }
                                    String daysList = medDaysList.join('، ');

                                    final medItems = MedItems(
                                        nameController.value.text,
                                        daysList,
                                        timeController.value.text,
                                        count.toString());
                                    log(medItems.toString());

                                    Navigator.pop(context, medItems);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'هناك خطأ في البيانات يرجي ملء جميع الحقول')),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ]));
  }
}
