import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import '../global/Globals.dart';


class UsefulMessage extends StatefulWidget {
  const UsefulMessage({super.key});

  @override
  State<UsefulMessage> createState() => _UsefulMessageState();
}


class _UsefulMessageState extends State<UsefulMessage> {



  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    homeText = homeText.copyWith(fontSize: screenSize.width * 0.07, fontStyle: FontStyle.italic) ;
    headerTextWhite = headerTextWhite.copyWith(fontSize: screenSize.width * 0.13);


    return MaterialApp(

    );

  }
}