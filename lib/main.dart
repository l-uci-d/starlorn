import 'package:starlorn/screens/collection.dart';
import 'package:starlorn/screens/manual.dart';

import './screens/home.dart'; 
import './screens/play.dart';


import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/play': (context) => const PlayStage(),
        '/manual': (context) => const UsefulMessage(),
        '/collection': (context) => const ProgressionGauge(),
        
      },
    );
  }
}