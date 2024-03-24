// ignore_for_file: prefer_const_constructors, file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:starlorn/main.dart';
import 'package:starlorn/models/Cards.dart';
import 'package:starlorn/screens/play.dart';
import 'package:flutter/services.dart' show rootBundle;

const Color 
darkpurp = Color.fromRGBO(76, 59, 113, 1),
whiteish = Color.fromRGBO(255, 238, 217, 1),
lightpurp = Color.fromRGBO(128,88,170, 1),
magenta = Color.fromRGBO(186, 30, 104, 1),
litebleu = Color.fromRGBO(165,189,253, 1),
pinkish = Color.fromRGBO(220, 181, 255, 1)
;



TextStyle uiText = TextStyle(
  color: whiteish,
  fontWeight: FontWeight.bold,
  fontFamily: 'NixieOne',
);

TextStyle homeText = TextStyle(
  color:   darkpurp,
  fontWeight: FontWeight.bold,
  fontFamily: 'NixieOne',
);

TextStyle homeSubText = TextStyle(
  color:   darkpurp,
  fontWeight: FontWeight.bold,
  fontFamily: 'NixieOne',
);

TextStyle headerTextWhite = TextStyle(
  color:  whiteish,
  fontFamily: 'Bayer-TypeArchiType',
);

TextStyle headerTextPurp = TextStyle(
  color:  lightpurp,
  

  fontFamily: 'Bayer-TypeArchiType',
);

TextStyle subHeaderText = TextStyle(
  color:  whiteish,
  fontFamily: 'Bayer-TypeArchiType',
);

TextStyle subHeaderTextRed = TextStyle(
  color: magenta,
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


Future<void> loadJsonData() async {
  String jsonString = await rootBundle.loadString('assets/text/collection.json');
  constellations = jsonDecode(jsonString).cast<Map<String, dynamic>>();

}

List<Map<String, dynamic>> constellations = [];

int 
cardCount = 0,
attempts = 0, 
mult = 0, 
uniquePairs = 0, 
totalUnique = 0,
rowCount = 0,
score = 0,
modChance = 0,
discoveryCount = 1,
highScoreEasy = 0,
highScoreHard = 0,
totalSeconds = 0
;

double aspectRatio = 0.0
;

String gameFin = '';

void setEasy(){
  score = 0;
  cardCount = 16;
  attempts = 9;
  mult = 1;
  modChance = 20;
  rowCount = 4;
  totalUnique = 5;
  aspectRatio = 1.90; 
}

void setHard(){
  score = 0;
  cardCount = 36;
  attempts = 15;
  mult = 2;
  modChance = 35;
  rowCount = 6;
  totalUnique = 10;
  aspectRatio = 1.90; 
}
