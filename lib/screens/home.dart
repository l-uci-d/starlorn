import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter/material.dart';
import './play.dart';
import '../global/Globals.dart';



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
    uiText = uiText.copyWith(fontSize: screenSize.width * 0.07);
    headerText = headerText.copyWith(fontSize: screenSize.width * 0.13);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),

          child: Center(
            child: Column(
            children: <Widget>[

              const Spacer(),
                Text('starlorn', style: headerText),

              const Spacer(flex: 5),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/play');
                }, 
                child: Text('Play', style: uiText),
              ),

              const SizedBox(height: spacerPadding),

              Text('How to Play', style: uiText),

              const SizedBox(height: spacerPadding),

              Text('Settings',
              style: uiText),

              const SizedBox(height: spacerPadding),

              Text('Account', style: uiText),

            const Spacer(),


            ].animate(interval: .1.seconds).fade(duration: .5.seconds, curve: Curves.easeOut).slideY()
            ,

          ),
          ),
        )
        ,
      )
    )
    
    ;
  }
}



