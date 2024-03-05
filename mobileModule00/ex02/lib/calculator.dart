import 'package:ex02/text_fields.dart';
import 'package:flutter/material.dart';
import 'custom_button.dart';

class Calculator extends StatefulWidget {

	const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
	String userInput = "Input";
	String result = "Result";

	List<String> buttons = [
	'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
	'AC',
	'C',
	'.', '=', '+',  '-' , '*' , '/'];

	

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
	  		body: Column(children: [TextFields(userInput: userInput, result: result),
			Expanded( child: Container(
				padding: const EdgeInsets.all(10),
				child: GridView.builder(
					itemCount: buttons.length,
					gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
						crossAxisCount: 4,
						crossAxisSpacing: 12,
						mainAxisSpacing : 12),
					itemBuilder: (BuildContext context, int index) {
						return CustomButton(buttonText: buttons[index]);
					},
						
						),
				)
			)])

			
		);
  }
}





