import 'package:flutter/material.dart';

import '../../constants/color_constatnts.dart';

Widget todolist({required bool isstarred, required Map model}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color.fromARGB(255, 238, 236, 236),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Stack(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  child: isstarred
                      ? const Icon(
                          Icons.star,
                          size: 40,
                          color: Colors.yellow,
                        )
                      : Container()),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${model['title']}',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.14),
                        child: const Icon(Icons.label_outline,
                            size: 28, color: AppColors.mintGreen),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${model['disc']}',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.14),
                      child: const Icon(Icons.sort_outlined,
                          size: 28, color: AppColors.mintGreen),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '${model['time']}',
                        style: const TextStyle(
                            color: AppColors.lightBlack, fontSize: 16),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Row(
                      children: [
                        Text(
                          '${model['date']}',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Icon(
                          Icons.calendar_month,
                          color: AppColors.mintGreen,
                          size: 28,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
