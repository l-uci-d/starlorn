import 'dart:math';

import 'package:flutter/material.dart';
import '../global/Globals.dart';
import 'dart:async';


const double padding = 35;

class PlayStage extends StatefulWidget {
  const PlayStage({super.key});
  

  @override
  State<PlayStage> createState() => _PlayStageState();
}


 int attempts = 9, 
 mult = 2, 
 uniquePairs = 5, 
 score = 10000, 
 totalUnique = 5
 ;


class _PlayStageState extends State<PlayStage> {
  

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
                height: screenSize.height * .7,
                width: screenSize.width * .9,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 238, 217, 1),
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
              ),

               Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('last pair: ', style: uiText,),
                  Container(
                    width: screenSize.width * 0.1,
                    decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 238, 217, 1),
                    ),

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





