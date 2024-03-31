
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:starlorn/global/Animations.dart';

import 'package:starlorn/models/CardGrid.dart';
import '../global/Globals.dart';
import '../models/Mechanics.dart';
import '../widgets/AlertDialogs.dart';
import 'dart:async';


const double padding = 35;
String lastPair = '';

class PlayStage extends StatefulWidget {
  const PlayStage({super.key});
  

  @override
  State<PlayStage> createState() => PlayStageState();

  
}


class PlayStageState extends State<PlayStage> {
  
  late Game game;
  late Duration duration;
  bool isPaused = false;


  
  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });

    if (isPaused) {
      showPauseDialog(context, () {
        setState(() {
          isPaused = false;
        });
        stopwatch.start();
        _startTimer();
      }
      );

      stopwatch.stop();
      timer.cancel();
      
    } else {
      stopwatch.start();
      _startTimer();
    }
  }



 
  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    uiText = uiText.copyWith(fontSize: screenSize.width * 0.045, color: whiteish);
    headerTextWhite = headerTextWhite.copyWith(fontSize: screenSize.width * 0.1);
    subHeaderText = subHeaderText.copyWith(fontSize: screenSize.width * 0.07, color:whiteish);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: 
        Container(
        
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(141, 82, 183, 1.0), // #FFFEF1
                Color.fromRGBO(155, 118, 245, 1.0), // #FFEEDD
              ],
            ),
          ),

            child: 
            Stack(
              children: <Widget>[
                BgAnim(null, 'stars'),
                Column(
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
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              
                              width: screenSize.width * 0.1,
                              child: Padding(
                                padding: EdgeInsets.only(top: screenSize.height * 0.01),
                                child: InkWell(
                                onTap: togglePause,
                                  child: 
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset('assets/images/pause.png',
                                    fit: BoxFit.cover
                                    )
                                  )
                                ),
                              ),
                            ),
                          FloatingWidget(
                            seed: (math.Random().nextDouble() * 2.0) - 2.0,
                            duration: Duration(seconds: math.Random().nextInt(10) + 3),
                            child: Container(
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
                            ).animate().boxShadow(),
                          )
                        ]
                        ),
                      ],
                      ),
                    ]
                  ),
                ]
              ),

                  Stack(
                    children: <Widget>[
                  
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top:screenSize.height*0.0095, bottom: screenSize.height*0.0095),
                    padding: EdgeInsets.all(screenSize.width * 0.05),
                    height: screenSize.height * .7,
                    width: screenSize.width * .9,
                    decoration: 
                      const BoxDecoration(
                      color: Color.fromRGBO(255, 238, 217, 1),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      
                    ),
                      child: Center(
                          child: (
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: rowCount,
                            scrollDirection: Axis.horizontal,
                            childAspectRatio: aspectRatio,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 5,
                            children: 
                            List.generate(game.cards.length, (index) {
                              return CardGrid(
                                index: index,
                                card: game.cards[index],
                                onCardPressed: game.onTapped,
                              );
                            } )
                          ).animate().fade(duration: .5.seconds, curve: Curves.easeOut).slideY()
                        ),
                      ),    
                    ),
                    ]
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: screenSize.width *0.01),
                        child: Text('last pair: ', style: uiText,)),
                      if(lastPair != '')
                      Image.asset(
                          'assets/cards/Values/$lastPair.png', 
                          width: screenSize.width * 0.15  ,
                          ),                  
                      SizedBox(width: screenSize.width*.23),

                      Text('time: ', style: uiText),
                      Text(formatTime(stopwatch.elapsedMilliseconds), style: subHeaderText,),

                    ],
                  )
                ]
                ) 
              ]
            )
          ),
        ),
      );
    }

  late Stopwatch stopwatch;
  late Timer timer;


  @override
  void initState() {
      super.initState();         
      gameFin = '';
      totalSeconds = 0;            
      uniquePairs = totalUnique;
      game = Game(cardCount, totalUnique, context);      
      lastPair = '';               

    stopwatch = Stopwatch();
    _startTimer();
    stopwatch.start();

  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), _updateTimer);
    
    stopwatch.start();
  }


  void _updateTimer(Timer timer) {
    if (stopwatch.isRunning && !isPaused && gameFin.isEmpty) {
      setState(() {
      });
    }
    totalSeconds = stopwatch.elapsed.inSeconds;
  }

  @override
  void dispose() {
    stopwatch.stop();
    super.dispose();
  }


}
