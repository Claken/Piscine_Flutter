import 'package:flutter/material.dart';
import 'text_fields.dart';
import 'custom_button.dart';

class Calculator extends StatefulWidget {

	const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
	String userInput = "454544";
	String result = "0";

	List<String> buttons = [
	'7', '8', '9', 'C', 'AC',
  '4', '5', '6', '+', '-',
  '1', '2', '3', '*', '/',
	'0', '.', '', '=', ''
  ];

  void handleButton(String buttonText) {

	setState(() {
	if (buttonText == 'AC') {
		userInput = "";
		result = "0";
		return;
		}
	});
  }

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
			Expanded( // widget that fills the available space of the widget that it's in
        		child: SizedBox(
				height: 10,
				child: GridView.builder(

					itemCount: buttons.length,
					gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
						crossAxisCount: 5,
						mainAxisExtent: 120,
						),
				  	itemBuilder: (BuildContext context, int index) {
						return CustomButton(buttonText: buttons[index], handleButton: handleButton,);
					},
						
						),
				)
			)])

			
		);
  }
}





