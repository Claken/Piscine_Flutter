import 'package:flutter/material.dart';
import 'functions.dart';
import 'image_section.dart';
import 'favorite_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
	const String appTitle = 'Flutter layout demo';

	return MaterialApp(
	  title: appTitle,
	  home: Scaffold( //
		appBar: AppBar(
		  title: const Text('OKTM')
		),
		body: const SingleChildScrollView(
		  child: Column(children: [
			ImageSection( image: 'images/lake.jpg'), 
			TitleSection(name: '42', location: "Paris, France"),
			ButtonSection(),
			TextSection(description:
			  'Lake Oeschinen lies at the foot of the Blüemlisalp in the '
			  'Bernese Alps. Situated 1,578 meters above sea level, it '
			  'is one of the larger Alpine Lakes. A gondola ride from '
			  'Kandersteg, followed by a half-hour walk through pastures '
			  'and pine forest, leads you to the lake, which warms to 20 '
			  'degrees Celsius in the summer. Activities enjoyed here '
			  'include rowing, and riding the summer toboggan run.',), 
		  ],)
		),
	  ),
	);
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
	super.key,
	required this.name,
	required this.location,
  }); // constructor

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) { // built describes the part of the user interface represented by this widget.
	return Padding(
	  padding: const EdgeInsets.all(32),
	  child: Row(
		children: [
		  Expanded(
			/*1*/
			child: Column(
			  crossAxisAlignment: CrossAxisAlignment.start,
			  children: [
				/*2*/
				Padding(
				  padding: const EdgeInsets.only(bottom: 1),
				  child: Text(
					name,
					style: const TextStyle(
					  fontWeight: FontWeight.bold,
					),
				  ),
				),
				Text(
				  location,
				  style: TextStyle(
					color: Colors.grey[0],
					fontStyle: FontStyle.italic
				  ),
				),
			  ],
			),
		  ),
		  /*3*/
      const FavoriteWidget(),
		],
	  ),
	);
  }
}
