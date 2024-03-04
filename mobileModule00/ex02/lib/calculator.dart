import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {

	const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
	String userInput = "";
	String result = "0";

	List<String> buttons = [
	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
	'.',
	'AC',
	'C',
	'=',
	'+',  '-' , '*' , '/ '];


	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: const Color.fromARGB(255, 7, 42, 56),
			appBar: AppBar(
			title: const Text('Calculator',
				style: TextStyle(color: Colors.white)),
				centerTitle: true,
				toolbarHeight: 60.2,
				backgroundColor: Colors.blueGrey,
			),
		);
  }
}





