import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:starlorn/global/Animations.dart';
import '../global/Globals.dart';
import 'dart:math' as math;



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Stopwatch _stopwatch;


Future<void> _showDifficulty() async {
  Size screenSize = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          
          backgroundColor: const Color.fromRGBO(255, 238, 221, 1.0),
          title:  Text('difficulty', style: headerTextPurp ),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                
                Container(
                  padding: const EdgeInsets.all(10),
                  height: screenSize.height * .25,
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[
                            Text('EASY', style: homeText),
                              Text('Card Amount: 16', style: homeSubText),
                              Text('Attempts: 9', style: homeSubText),
                              Text('Starting Mult: 1', style: homeSubText),
                              Text('Mods Chance: 20', style: homeSubText),
                              Text('Unique Pairs: 5', style: homeSubText),
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
                            Text('HARD', style: homeText),
                              Text('Card Amount: 36', style: homeSubText),
                              Text('Attempts: 15', style: homeSubText),
                              Text('Starting Mult: 2', style: homeSubText),
                              Text('Mods Chance: 35', style: homeSubText),
                              Text('Unique Pairs: 10', style: homeSubText),
                    
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
                    backgroundColor: const Color.fromRGBO(128,88,170, 1), 
                  ),
                  child:  Text('play',  style: subHeaderText),
                  onPressed: () {
                    score = 0;
                    cardCount = 16;
                    attempts = 9;
                    mult = 1;
                    modChance = 20;
                    rowCount = 4;
                    totalUnique = 5;
                    aspectRatio = 1 + 0.5013927576601672; 
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/play');
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(186, 30, 104, 1), 
                  ),
                  child:  Text('play', style: subHeaderText),
                  onPressed: () {
                    score = 0;
                    cardCount = 36;
                    attempts = 15;
                    mult = 2;
                    modChance = 35;
                    rowCount = 6;
                    totalUnique = 10;
                    aspectRatio = 1 + 0.4621309370988447; 

                    Navigator.of(context).pop();
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
              )
              ,

          ],
        );
      },
    );
  }



  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _stopwatch.start();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    homeText = homeText.copyWith(fontSize: screenSize.width * 0.06,);
    homeSubText = homeSubText.copyWith(fontSize: screenSize.width * 0.04,);
    headerTextWhite = headerTextWhite.copyWith(fontSize: screenSize.width * 0.13);
    headerTextPurp = headerTextPurp.copyWith(fontSize: screenSize.width * 0.10);
    subHeaderText = subHeaderText.copyWith(fontSize: screenSize.width * 0.055, );
    subHeaderTextRed = subHeaderTextRed.copyWith(fontSize: screenSize.width * 0.055, );


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(76, 59, 113, 1.0), // #FFFEF1
                Color.fromRGBO(2, 31, 75, 1.0), // #FFEEDD
              ],
            ),
          ),
          child:
          Stack(
            children: <Widget>[
              BgAnim(null),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  const Spacer(),
                    Text('starlorn', style: headerTextWhite),

                  const Spacer(flex: 5),

                  FloatingWidget(
                    seed: (math.Random().nextDouble() * 2.0) - 2.0,
                    duration: Duration(seconds: math.Random().nextInt(10) + 5),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 238, 217, 1), // Set the background color
                      ),
                      onPressed: () {
                        _showDifficulty();
                      }, 
                      child: Text('Shoot for the Stars!', style: homeText),
                    ),
                  )
                  ,

                  const SizedBox(height: spacerPadding),

                  FloatingWidget(
                    seed: (math.Random().nextDouble() * 2.0) - 2.0,
                    duration: Duration(seconds: math.Random().nextInt(10) + 3),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 238, 217, 1), // Set the background color
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/manual');
                      }, 
                      child: Text('Manual', style: homeText),
                    ),
                  ),

                  const SizedBox(height: spacerPadding),

                  FloatingWidget(
                    seed: (math.Random().nextDouble() * 2.0) - 2.0,
                    duration: Duration(seconds: math.Random().nextInt(10) + 3),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 238, 217, 1), // Set the background color
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/collection');
                      }, 
                      child: Text('Collection', style: homeText),
                    ),
                  ),


                const Spacer(),


                ].animate(interval: .1.seconds).fade(duration: .5.seconds, curve: Curves.easeOut).slideY()
                ,

              ),   
              ),

            ],
          )
        ),
      )
    )
    
    ;
  }
}



