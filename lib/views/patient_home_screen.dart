import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:memory_mate/components/buttons.dart';
import 'package:memory_mate/components/text_fields.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  printit() {
    if (kDebugMode) {
      print('object');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textField(),
          const SizedBox(
            height: 20,
          ),
          textField(),
          const SizedBox(
            height: 20,
          ),
          filledButton(function: () {
            printit();
          }),
          const SizedBox(
            height: 20,
          ),
          filledIconButton(function: () {
            printit();
          }),
          const SizedBox(
            height: 20,
          ),
          outlineButton(function: () {
            printit();
          }),
          const SizedBox(
            height: 20,
          ),
          outlineIconButton(function: () {
            printit();
          }),
        ],
      )),
    );
  }
}
