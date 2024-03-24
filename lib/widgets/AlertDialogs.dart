

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:starlorn/global/Globals.dart';
import '../screens/play.dart';
import 'dart:math';

Future<void> showDifficulty(BuildContext context) async {
  Size screenSize = MediaQuery.of(context).size;
  homeSubText = homeSubText.copyWith(color: darkpurp);
  subHeaderText = subHeaderText.copyWith(fontSize: screenSize.width * 0.050);
    return showDialog<void>(
      context: context,
      
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          
          alignment: Alignment.center,
          
          backgroundColor: whiteish,
          title:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              
                children: <Widget>[
                  
                  Text('difficulty', style: headerTextPurp),
                  const Baseline(
                    baseline: 1,
                    baselineType: TextBaseline.alphabetic,
                    child: 
                      Divider(
                        
                        color: magenta,
                        thickness: 3.5,
                        height: 1
                      ),
                  )
                ]
              ),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                
                Container(
                  padding: const EdgeInsets.all(5),
                  height: screenSize.height * .35,
                  width: screenSize.width * .90,
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[
                            Text('EASY', style: homeText.copyWith(decoration: TextDecoration.underline)),
                              Text('Card Amt: 16', style: homeSubText),
                              Text('Attempts: 9', style: homeSubText),
                              Text('Start Mult: 1', style: homeSubText),
                              Text('Mods %: 20', style: homeSubText),
                              Text('Unique: 5', style: homeSubText),
                              const Spacer(),
                              Text('High Score: ', style: homeSubText.copyWith(decoration: TextDecoration.underline)),
                              Text('$highScoreEasy', style: homeSubText),
                        ],),

                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                          color: Colors.black,
                        ),
                    
                        Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('HARD', style: homeText.copyWith(decoration: TextDecoration.underline)),
                              Text('Card Amt: 36', style: homeSubText),
                              Text('Attempts: 15', style: homeSubText),
                              Text('Start Mult: 2', style: homeSubText),
                              Text('Mods %: 35', style: homeSubText),
                              Text('Unique Pairs: 10', style: homeSubText),
                              const Spacer(),
                              Text('High Score: ', style: homeSubText.copyWith(decoration: TextDecoration.underline)),
                              Text('$highScoreHard', style: homeSubText),
                    
                        ],),
                    
                    ],
                    ),
                  
                ),
                
              ],
            ),
          ),
          actions: <Widget>[
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: lightpurp, 
                  ),
                  child:  Text('play',  style: subHeaderText),
                  onPressed: () {
                    setEasy();
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    Navigator.pushNamed(context, '/play');
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: magenta, 
                  ),
                  child:  Text('play', style: subHeaderText),
                  onPressed: () {
                    setHard();

                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    Navigator.pushNamed(context, '/play');
                  },
                ),
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: lightpurp, 
                  ),
                  child:  Text('no mods',  style: subHeaderText),
                  onPressed: () {
                    setEasy();
                    modChance = 0;
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    Navigator.pushNamed(context, '/play');
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: magenta, 
                  ),
                  child:  Text('no mods', style: subHeaderText),
                  onPressed: () {
                    setHard();
                    modChance = 0;

                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    Navigator.pushNamed(context, '/play');
                  },
                ),
              ]
            ),
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child:  Text('Back',  style: homeText),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),

          ],
        ).animate().fade(duration: .5.seconds, curve: Curves.easeOut).slideY(begin: 0.5, end: 0)
                
        ;
      },
    );
  }
  

Future<void> showPauseDialog(BuildContext context, VoidCallback onResume) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: darkpurp,
        title:  Text('paused', style: headerTextWhite),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Quitting will not save your progress.', style: uiText),
              Text('What would you like to do?', style: uiText),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child:  Text('Resume',  style: uiText),
            onPressed: () {
              Navigator.of(context).pop();
              onResume();

            },
          ),
          TextButton(
            child:  Text('Quit', style: uiText.copyWith(color: magenta)),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            },
          ),
        ],
      );
    },
  );
}


Future<void> showGameFin(BuildContext context) async {
  print(totalSeconds);
  Size screenSize = MediaQuery.of(context).size;


  int timeScore = 60 ~/ totalSeconds;
  int attemptScore = attempts > 0 ? (attempts * 1.25).floor() : (attempts ~/ 2);
  int finalMult = (mult + attemptScore + timeScore);
  int finalScore = score * finalMult;


    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(

          
          backgroundColor: whiteish,
          title:  
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              
                children: <Widget>[
                  
                  Text(gameFin, style: headerTextWhite.copyWith(color: darkpurp)),
                  const Baseline(
                    baseline: 1,
                    baselineType: TextBaseline.alphabetic,
                    child: 
                      Divider(
                        
                        color: magenta,
                        thickness: 3.5,
                        height: 1
                      ),
                  )

                ]
              ),
              
            

            content:  SingleChildScrollView(
            child: ListBody(
              
              children: <Widget>[
                  Container(
                    height: screenSize.height * .35,
                    child:
                  Row(
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Final Score: $score', style: uiText.copyWith(color: darkpurp)),
                                  Text('Final Mult: $mult', style: uiText.copyWith(color: darkpurp)),
                                  Text('Attempts Score: $attempts', style: uiText.copyWith(color: darkpurp)),
                                  Text('Time Score: $timeScore', style: uiText.copyWith(color: darkpurp)),
                                  
                                  const Spacer(),
                                  Text('$score * ($mult + $attempts + $timeScore)', style: uiText.copyWith(color: darkpurp)),
                                  Text('Total Score: $finalScore', style: uiText.copyWith(color: darkpurp)),
                                  const Spacer(),
                                  if(discoveryCount >1)
                                  Text('New Discoveries: $discoveryCount', style: uiText.copyWith(color: darkpurp)) ,
                                  
                              ],),
                    ],
                  ),
                  )
                          
              ]
                  )
            )


          ,actions: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: darkpurp, 
                    ),
                    child:  Text('Home',  style: uiText),
                    onPressed: () {
                      Navigator.of(context).popUntil(ModalRoute.withName('/')); 
                    },
                  ),

                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: darkpurp, 
                    ),
                    child:  Text('Replay',  style: uiText),
                    onPressed: () {
                      showDifficulty(context);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }





