import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/color_constatnts.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import 'addtodo.dart';

class DoneTodo extends StatelessWidget {
  const DoneTodo({super.key});
  get state => null;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Column(children: [
        ConditionalBuilder(
          condition: state is! ApptDatabaseLoadState,
          builder: (context) => Expanded(
            child: BlocConsumer<AppCubit, AppStates>(
              builder: (BuildContext context, state) {
                var tasks = AppCubit.get(context).donetasks;

                return ConditionalBuilder(
                  builder: (BuildContext context) => ListView.separated(
                    itemBuilder: (context, index) => Dismissible(
                      direction: DismissDirection.startToEnd,
                      key: ObjectKey(tasks[tasks.length - 1]),
                      onDismissed: (direction) {
                        AppCubit.get(context)
                            .deleteStatus(id: tasks[index]['id']);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('تم إلغاء المهمة'),
                          backgroundColor: Colors.red,
                        ));
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0, left: 10),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'مرر لإلغاء المهمة',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      child: todolist(
                          isstarred:
                              tasks[index]['star'] == 'true' ? true : false,
                          model: tasks[index]),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 1),
                    itemCount: tasks.length,
                  ),
                  condition: tasks.isNotEmpty,
                  fallback: (BuildContext context) => Image.asset(
                    'assets/images/pictures/Group 241.png',
                    width: 300,
                  ),
                );
              },
              listener: (BuildContext context, Object? state) {},
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        )
      ]),
    );
  }
}
