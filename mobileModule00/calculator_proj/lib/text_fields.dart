import 'package:flutter/material.dart';
import 'package:extended_text/extended_text.dart';

class TextFields extends StatelessWidget {

	final String userInput;
	final String result;

	const TextFields({
		super.key,
		required this.userInput,
		required this.result,
	});

	@override
	Widget build(BuildContext context) {
		return 	SizedBox(
	  // height: MediaQuery.of(context).size.height / 3,
	  child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
		Container(
		  padding: const EdgeInsets.all(20),
		  alignment: Alignment.centerRight,
		  child: ExtendedText(
			userInput,
			maxLines: 1,
				overflowWidget: const TextOverflowWidget(
				position: TextOverflowPosition.start,
			child: Text("", style: TextStyle(fontSize: 32))
			),
			style: const TextStyle(
			  fontSize: 32,
			  color: Colors.white,)

			),
		  ),
		Container(
		  padding: const EdgeInsets.all(10),
		  alignment: Alignment.centerRight,
		  child: ExtendedText(
			result,
			maxLines: 1,
			overflowWidget: const TextOverflowWidget(
				position: TextOverflowPosition.start,
				child: Text("", style: TextStyle(fontSize: 48))
			),
			style: const TextStyle(
			  	fontSize: 48,
			  	color: Colors.white,
				fontWeight: FontWeight.bold
			),
				
			),
		  ),
		// const Divider(color: Colors.white,)
	  ],)
	);
	}

}