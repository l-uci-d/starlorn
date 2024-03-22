// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';


TextStyle uiText = TextStyle(
  color:  Color.fromRGBO(255, 238, 217, 1),
  fontWeight: FontWeight.bold,
  fontFamily: 'NixieOne',
);

TextStyle homeText = TextStyle(
  color:   Color.fromRGBO(76, 59, 113, 1),
  fontWeight: FontWeight.bold,
  fontFamily: 'NixieOne',
);

TextStyle homeSubText = TextStyle(
  color:   Color.fromRGBO(76, 59, 113, 1),
  
  fontFamily: 'NixieOne',
);

TextStyle headerTextWhite = TextStyle(
  color:  Color.fromRGBO(255, 238, 217, 1),
  fontFamily: 'Bayer-TypeArchiType',
);
TextStyle headerTextPurp = TextStyle(
  color:  Color.fromRGBO(128,88,170, 1),
  decoration: TextDecoration.underline,
  decorationColor: Colors.black,
  fontFamily: 'Bayer-TypeArchiType',
);

TextStyle subHeaderText = TextStyle(
  color:  Color.fromRGBO(255, 238, 217, 1),
  fontFamily: 'Bayer-TypeArchiType',
);

TextStyle subHeaderTextRed = TextStyle(
  color: const Color.fromRGBO(186, 30, 104, 1),
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


int 
cardCount = 0,
attempts = 0, 
mult = 0, 
uniquePairs = 0, 
totalUnique = 0,
rowCount = 0,
score = 0,
modChance = 0
;
double aspectRatio = 0.0;