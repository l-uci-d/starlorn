import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:starlorn/firebase_options.dart';
import 'package:starlorn/global/Globals.dart';
import 'package:starlorn/models/Collections.dart';
import 'package:starlorn/screens/collection.dart';
import 'package:starlorn/screens/manual.dart';

import './screens/home.dart'; 
import './screens/play.dart';


import 'package:flutter/material.dart';

import 'screens/leaderboards.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadJsonData();

     await Firebase.initializeApp(
 options: DefaultFirebaseOptions.currentPlatform);
   
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
        '/leaderboard': (context) => const LeaderboardPage()
      },
    );
  }
}