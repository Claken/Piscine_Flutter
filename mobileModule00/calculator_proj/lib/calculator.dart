import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'text_fields.dart';
import 'custom_button.dart';

class Calculator extends StatefulWidget {

	const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
	String userInput = "0";
	String result = "";

	List<String> buttons = [
	'7', '8', '9', 'C', 'AC',
  '4', '5', '6', '+', '-',
  '1', '2', '3', '*', '/',
	'0', '.', '', '=', ''
  ];

  String 	calculate() {
	try
	{
		var exp = Parser().parse(userInput);
		debugPrint("exp == $exp.toString()");
		var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
		debugPrint("eval == $evaluation.toString()");
		return evaluation.toString();
	}
	catch (e) {

		if (e.toString().length > 10) {
			return "Invalid Expression";
		}
		return ("$e");
	}
  }

  void		handleButton(String buttonText) {

	setState(() {
	if (buttonText == 'AC') {
		userInput = "0";
		result = "";
	}
	else if (buttonText == 'C') {
		userInput = userInput.length == 1 ?
		"0" : userInput.substring(0, userInput.length - 1);
	}
	else if (buttonText == '=') {
		
		result = calculate();
		if (result.endsWith(".0")) {
			result = result.replaceAll(".0", "");
		}
		userInput = "0";
	}
	else {
		userInput = userInput == "0" ?
		buttonText :
		userInput + buttonText;
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
						mainAxisExtent: 120, //
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





