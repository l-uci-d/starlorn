
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:starlorn/global/Animations.dart';

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


class _PlayStageState extends State<PlayStage> {
  late Timer timer;
  late Game game;
  late Duration duration;
  bool _isPaused = false;

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });

    if (_isPaused) {
      _showPauseDialog();
      _stopwatch.stop(); 
      _timer?.cancel(); 
    } else {
      _stopwatch.start();
      _startTimer(); 
    }
  }

  Future<void> _showPauseDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(76, 59, 113, 1),
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
                _togglePause(); 
              },
            ),
            TextButton(
              child:  Text('Quit', style: uiText),
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
 
  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    uiText = uiText.copyWith(fontSize: screenSize.width * 0.045);
    headerTextWhite = headerTextWhite.copyWith(fontSize: screenSize.width * 0.16);
    subHeaderText = subHeaderText.copyWith(fontSize: screenSize.width * 0.07, color:const Color.fromRGBO(255, 238, 217, 1));

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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          
                          width: screenSize.width * 0.1,
                          child: Padding(
                            padding: EdgeInsets.only(top: screenSize.height * 0.01),
                            child: InkWell(
                             onTap: _togglePause,
                              child: 
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset('assets/images/pause.png',
                                fit: BoxFit.cover
                                )
                              )
                            ),
                          ),
                        )

,
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
                  child: 
                     Center(
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
                      width: screenSize.width * 0.1  ,
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

  late Timer _timer;

  @override
  void initState() {

      super.initState();                     
      uniquePairs = totalUnique;
      game = Game(cardCount, totalUnique);        

      // 0.4621309370988447
      // 0.5013927576601672
      // 1.65
      // aspectRatio = 1.855                 

    _stopwatch = Stopwatch();
    _startTimer();
    _stopwatch.start();

  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), _updateTimer);
    _stopwatch.start();
  }


  void _updateTimer(Timer timer) {
    if (_stopwatch.isRunning && !_isPaused) {
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





