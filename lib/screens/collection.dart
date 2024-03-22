import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import '../global/Globals.dart';


class ProgressionGauge extends StatefulWidget {
  const ProgressionGauge({super.key});

  @override
  State<ProgressionGauge> createState() => _ProgressionGauge();
}


class _ProgressionGauge extends State<ProgressionGauge> {



  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    homeText = homeText.copyWith(fontSize: screenSize.width * 0.07, fontStyle: FontStyle.italic) ;
    headerTextWhite = headerTextWhite.copyWith(fontSize: screenSize.width * 0.13);


    return MaterialApp(

    );

  }
}