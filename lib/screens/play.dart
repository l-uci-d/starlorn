

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:starlorn/models/CardGrid.dart';
import '../global/Globals.dart';
import '../models/Mechanics.dart';
import 'dart:async';


const double padding = 35;
String lastPair = '';

class PlayStage extends StatefulWidget {
  const PlayStage({super.key});
  

  @override
  State<PlayStage> createState() => _PlayStageState();
}



 int attempts = 9, 
 mult = 2, 
 uniquePairs = 5, 
 score = 0, 
 totalUnique = 5
 ;


class _PlayStageState extends State<PlayStage> {
  late Timer timer;
  late Game game;
  late Duration duration;
 
  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    uiText = uiText.copyWith(fontSize: screenSize.width * 0.045);
    headerText = headerText.copyWith(fontSize: screenSize.width * 0.16);
    subHeaderText = subHeaderText.copyWith(fontSize: screenSize.width * 0.07);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 200),

          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg_play.png'),
              fit: BoxFit.cover,
            ),
          ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                
                Column(
                children: <Widget>[

                  Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text('Attempts Left: $attempts', style: uiText),
                        Text('Multiplier: $mult''x', style: uiText),
                        Text('Unique pairs left: $uniquePairs''/$totalUnique', style: uiText),
                        ]
                      ),
                    ),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                      TextButton(
                      onPressed: () {
                      Navigator.pop(context, '/play');
                      }, 
                      child:
                        Text('Back', style: uiText)
                      ),

                      Container(
                        padding: const EdgeInsets.only(left: 12.0),
                        width: screenSize.width *.40,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color.fromRGBO(5, 10, 48, 1),
                            ),     
                        child: 
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('score:', style : subHeaderText),
                              
                              Center(
                                child: Text('$score', style : subHeaderText),
                              ),
                            ],
                        ),
                      )
                    ]
                    ),
                  ],
                  ),
                ]
              ),
            ]
          ),


              Container(
                margin: EdgeInsets.only(top:screenSize.height*0.0095, bottom: screenSize.height*0.0095),
                padding: EdgeInsets.all(screenSize.width * 0.05),
                height: screenSize.height * .7,
                width: screenSize.width * .9,
                decoration: 
                  const BoxDecoration(
                  color: Color.fromRGBO(255, 238, 217, 1),
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                

                  child: 
                     GridView.count(
                      scrollDirection: Axis.vertical,
                      childAspectRatio: 0.65,
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(game.cards.length, (index) {
                        return CardGrid(
                          index: index,
                          card: game.cards[index],
                          onCardPressed: game.onTapped,
                        )
                        
                        ;
                      }
                      )
                    ).animate().fade(duration: .5.seconds, curve: Curves.easeOut).slideY()
                  )
              ,

        
               Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: screenSize.width *0.01),
                    child: Text('last pair: ', style: uiText,)),
                  if(lastPair != '')
                  Image.asset(
                      'assets/cards/Values/$lastPair.png', 
                      width: screenSize.width * 0.15 ,
                      ),

                  
                  SizedBox(width: screenSize.width*.23),

                  Text('time: ', style: uiText),
                  Text(formatTime(_stopwatch.elapsedMilliseconds), style: subHeaderText,),


                ],
              )
          
          ]
          )
        ),
      ),
    );
  }

  late Stopwatch _stopwatch;
  // ignore: unused_field
  late Timer _timer;

  @override
  void initState() {
      super.initState();
      lastPair = '';
      score = 0;
      attempts = 9;                       // add dynamic values
      game = Game(5, uniquePairs);        // add dynamic values
      mult = 1;                           // add dynamic values

    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 100), _updateTimer);
    _stopwatch.start();
  }

  void _updateTimer(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {
      });
    }
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }
}





