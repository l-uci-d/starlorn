// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';


TextStyle uiText = TextStyle(
  color:  Color.fromRGBO(255, 238, 217, 1),
  fontWeight: FontWeight.bold,
  fontFamily: 'NixieOne',
);

TextStyle headerText = TextStyle(
  color:  Color.fromRGBO(255, 238, 217, 1),
  fontFamily: 'Bayer-TypeArchiType',
);

TextStyle subHeaderText = TextStyle(
  color:  Color.fromRGBO(255, 238, 217, 1),
  fontFamily: 'Bayer-TypeArchiType',
);

const double spacerPadding = 35;


String formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }


   