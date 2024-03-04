import 'package:flutter/material.dart';
import 'dart:developer';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
	  	home: Scaffold(body: 
		Column(mainAxisAlignment: MainAxisAlignment.center, children: [Center(
          	child: Container(
    		padding:  const EdgeInsets.all(10.0),
    		decoration: BoxDecoration(
      		border: Border.all(), color: Colors.grey
       	 ),
    	child: const Text(
      	"A Simple Text", style: TextStyle(color: Colors.white)),
  	)	,), const SizedBox(height: 5),
    ElevatedButton(onPressed: () { log('button pressed');},
  		child: const Text('click here'),
)
])
	 
    ));
  }
}

