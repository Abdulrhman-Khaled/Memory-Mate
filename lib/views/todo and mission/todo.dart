// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:simple_speed_dial/simple_speed_dial.dart';
import '../../constants/color_constatnts.dart';
import '../../controllers/cubit/cubit.dart';
import '../../controllers/cubit/states.dart';
import '../medicines and alarms/add_field.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final _formKey = GlobalKey<FormState>();

  var hourcontroller = TextEditingController();

  var mincontroller = TextEditingController();

  var datecontroller = TextEditingController();

  var namecontroller = TextEditingController();

  var desccontroller = TextEditingController();

  var timecontroller = TextEditingController();

  int? hourPicker;
  int? minPicker;

  Color starcolor = AppColors.white;

  bool isstarred = true;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      confirmText: "تعيين",
      cancelText: "إلغاء",
      initialEntryMode: TimePickerEntryMode.dialOnly,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        FocusManager.instance.primaryFocus?.unfocus();
        hourPicker = pickedTime.hour;
        minPicker = pickedTime.minute;
        timecontroller.text = pickedTime.format(context).toString();
      });
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.parse('2029-01-01'),
      locale: const Locale('ar', 'SA'),
    );
    if (picked != null) {
      setState(() {
        FocusManager.instance.primaryFocus?.unfocus();
        datecontroller.text =
            DateFormat.yMEd('ar_SA').format(picked).toString();
      });
    }
  }

  Future<void> refresh() async {
    setState(() {});
    refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      onRefresh: refresh,
      child: BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);          
            return Scaffold(
                appBar: AppBar(
                  leading: AppCubit.get(context).currentIndex == 0
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        )
                      : IconButton(
                          onPressed: () {
                            AppCubit.get(context).changescreens(0);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                  elevation: 0,
                  actions: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              cubit.titles[cubit.currentIndex],
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                floatingActionButton: SpeedDial(
                  closedForegroundColor: Colors.white,
                  openForegroundColor: AppColors.mintGreen,
                  closedBackgroundColor: AppColors.mintGreen,
                  openBackgroundColor: Colors.white,
                  labelsStyle: const TextStyle(),
                  labelsBackgroundColor: Colors.white,
                  speedDialChildren: <SpeedDialChild>[
                    SpeedDialChild(
                      child: const Icon(Icons.add),
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.mintGreen,
                      label: 'إضافة مهمة',
                      onPressed: () {
                        AppCubit.get(context).changescreens(0);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              backgroundColor: AppColors.mintGreen,
                              title: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.white,
                                ),
                                child: const Center(
                                  child: Text(
                                    'إضافة مهمة جديدة',
                                    style: TextStyle(
                                      color: AppColors.mintGreen,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                              content: StatefulBuilder(
                                builder: (context, setState) {
                                  return SingleChildScrollView(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Text(
                                              'تمييز المهمة بنجمة',
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: AppColors.white,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (kDebugMode) {
                                                    print('ok');
                                                  }
                                                  isstarred = !isstarred;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.star,
                                                size: 35,
                                                color: isstarred
                                                    ? Colors.yellow
                                                    : AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Container(
                                                height: 70,
                                                width: 270,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: const Color.fromARGB(
                                                        221, 245, 244, 244)),
                                                child: addfield2(
                                                    hint: 'أسم المهمة',
                                                    nameController:
                                                        namecontroller))),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Container(
                                                height: 70,
                                                width: 270,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    color: const Color.fromARGB(
                                                        221, 245, 244, 244)),
                                                child: addfield2(
                                                    hint: 'وصف المهمة',
                                                    icon: Icons.sort,
                                                    nameController:
                                                        desccontroller))),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          child: Container(
                                            height: 70,
                                            width: 270,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: const Color.fromARGB(
                                                    221, 245, 244, 244)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 0),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'يرجي تحديد الوقت';
                                                    }
                                                    return null;
                                                  },
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 22,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                  controller: timecontroller,
                                                  decoration:
                                                      const InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.timelapse_outlined,
                                                      size: 37,
                                                      color:
                                                          AppColors.mintGreen,
                                                    ),
                                                    hintText: 'سجل الوقت',
                                                    hintStyle:
                                                        TextStyle(fontSize: 20),
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    _selectTime(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Container(
                                            height: 70,
                                            width: 270,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: const Color.fromARGB(
                                                    221, 245, 244, 244)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 0),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'يرجي تحديد الميعاد';
                                                    }
                                                    return null;
                                                  },
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 22,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                  controller: datecontroller,
                                                  decoration:
                                                      const InputDecoration(
                                                    suffixIcon: Icon(
                                                      Icons.calendar_month,
                                                      size: 37,
                                                      color:
                                                          AppColors.mintGreen,
                                                    ),
                                                    hintText: 'سجل التاريخ',
                                                    hintStyle:
                                                        TextStyle(fontSize: 20),
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    pickDate(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  );
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'إلغاء',
                                    style: TextStyle(
                                        color: AppColors.white, fontSize: 20),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      cubit.insertToDatabase(
                                        title: namecontroller.text,
                                        disc: desccontroller.text,
                                        date: datecontroller.text,
                                        time: timecontroller.text,
                                        star: isstarred,
                                      );
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Text(
                                    'إنشاء',
                                    style: TextStyle(
                                        color: AppColors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      closeSpeedDialOnPressed: false,
                    ),
                    SpeedDialChild(
                      child: const Icon(Icons.check),
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.mintGreen,
                      label: 'المهام المنجزة ',
                      onPressed: () {
                        AppCubit.get(context).changescreens(1);
                      },
                    ),
                    SpeedDialChild(
                      child: const Icon(Icons.star),
                      foregroundColor: Colors.yellow,
                      backgroundColor: AppColors.mintGreen,
                      label: 'المهام المميزة بنجمة',
                      onPressed: () {
                        AppCubit.get(context).changescreens(2);
                      },
                    ),
                  ],
                  child: const Icon(Icons.menu),
                ),
                backgroundColor: AppColors.mintGreen,
                body: AppCubit.get(context)
                    .screens[AppCubit.get(context).currentIndex]);
          },
          listener: (BuildContext context, AppStates state) {},
        ),
      ),
    );
  }
}
