import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:starlorn/global/Animations.dart';
import '../global/Globals.dart';
import '../widgets/AlertDialogs.dart';
import 'dart:math' as math;



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Stopwatch _stopwatch;






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
    subHeaderText = subHeaderText.copyWith(fontSize: screenSize.width * 0.050,);
    subHeaderTextRed = subHeaderTextRed.copyWith(fontSize: screenSize.width * 0.050, );


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
              BgAnim(null, 'stars'),
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
                        backgroundColor: const Color.fromRGBO(255, 238, 217, 1), 
                      ),
                      onPressed: () {
                        showDifficulty(context);
                      }, 
                      child: Text('Play', style: homeText),
                    ),
                  ),

                  const SizedBox(height: spacerPadding),

                  FloatingWidget(
                    seed: (math.Random().nextDouble() * 2.0) - 2.0,
                    duration: Duration(seconds: math.Random().nextInt(10) + 3),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 238, 217, 1), 
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

                  const SizedBox(height: spacerPadding),

                // FloatingWidget(
                //     seed: (math.Random().nextDouble() * 2.0) - 2.0,
                //     duration: Duration(seconds: math.Random().nextInt(10) + 3),
                //     child: TextButton(
                //       style: TextButton.styleFrom(
                //         backgroundColor: const Color.fromRGBO(255, 238, 217, 1), // Set the background color
                //       ),
                //       onPressed: () {
                //         Navigator.pushNamed(context, '/leaderboard');
                //       }, 
                //       child: Text('Leaderboards', style: homeText),
                //     ),
                //   ),

                  const Spacer()

                ].animate(interval: .1.seconds).fade(duration: .5.seconds, curve: Curves.easeOut).slideY()
                ,
              ),   
              ),
            ],
          )
        ),
      )
    );
  }
}



