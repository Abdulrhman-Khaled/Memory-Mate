import 'dart:async';
import 'package:flutter/material.dart';
import 'onboard.dart';


class MyHomePage extends StatefulWidget {
@override
_MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
@override
void initState() {
	super.initState();
	Timer(Duration(seconds: 2),
		()=>Navigator.pushReplacement(context,
										MaterialPageRoute(builder:
														(context) =>
														OnBoard()
														)
									)
		);
}
@override
Widget build(BuildContext context) {
	return Container(
	color: Color.fromARGB(255, 143, 207, 201),
	child: Image.asset(
                    'assets/images/logos/logo.png',
                    height: 90.0,
                    width: 90.0,
                  ),
  );
}
}