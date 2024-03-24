import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:starlorn/global/Animations.dart';
import '../global/Globals.dart';
import 'dart:math' as math;


class UsefulMessage extends StatefulWidget {
  const UsefulMessage({super.key});

  @override
  State<UsefulMessage> createState() => _UsefulMessageState();
}


class _UsefulMessageState extends State<UsefulMessage> {



  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    homeText = homeText.copyWith(fontSize: screenSize.width * 0.07, fontStyle: FontStyle.italic) ;
    headerTextWhite = headerTextWhite.copyWith(fontSize: screenSize.width * 0.13);
    homeSubText = homeSubText.copyWith(color: darkpurp, fontSize: screenSize.width *0.035);

    return MaterialApp(
      home:Scaffold(
      body:         Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_collection.png'),
                fit: BoxFit.cover,
              ),
            ),
            child:  
              Stack(
                alignment: Alignment.topLeft,
                
                children: <Widget>[
                  BgAnim(null, 'stars_negative'),
                  
                Padding(padding: EdgeInsets.all(screenSize.width * 0.06),
                child: 
                  Center(
                    child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: darkpurp, 
                              ),
                              onPressed: () {
                                Navigator.of(context).popUntil(ModalRoute.withName('/'));
                              }, 
                              child: Text('<-', style: homeSubText.copyWith(color: whiteish)),
                            ),
                            Expanded(child: 
                            Center(child: Text('manual', style: headerTextPurp),
                            )
                            ),
                          ],
                          ),
                          Container(
                            
                            padding: const EdgeInsets.all(25),
                            width: screenSize.width * .9,
                            height: screenSize.height * 0.85,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                                gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  litebleu,
                                  pinkish 
                                ],
                              ),
                            ),
                          child: 
                          SingleChildScrollView(child: 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Text('Welcome to Starlorn. The goal of the game is to pair all cards in the given grid.', 
                            style: homeSubText,),
                            Text(' '
                            , style: homeSubText),

                                    GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: 16, 
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4, 
                                        crossAxisSpacing: 4.0, 
                                        mainAxisSpacing: 4.0,
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                        return FloatingWidget(
                                        seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                        duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                        child: 
                                      Transform.scale(scale: 0.65, child: Image.asset(
                                        'assets/cards/Values/cardback.png',
                                         fit: BoxFit.fitWidth,
                                      ).animate().boxShadow())
                                      );
                                      },
                                    ),

                            Text(' '
                            , style: homeSubText),
                            Text('    You match cards by tapping two different cards. Those two cards will then reveal their corresponding value and modifier.', 
                            style: homeSubText,),
                            Text('    Their value is represented by one of 48 different possible constellations, a limited number of which are in the board. If their values match, then the two cards will disappear from the board.', 
                            style: homeSubText,),
                            Text('    If not, then you will be subtracted one pair attempt, shown as a number at the top of the board. You lose the game when you run out of pair attempts.', 
                            style: homeSubText,),
                            Text('    The game also features 10 different modifiers, 5 of which are power ups, and the other 5 are power downs.', 
                            style: homeSubText,),
                            Text('    Each has their own unique effects when either paired, selected, or unsuccessfuly paired.', 
                            style: homeSubText,),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),
                            Text(' '
                            , style: homeSubText),
                            Text('Here are the 5 power down modifiers:'
                            , style: homeSubText),
                            Text(' '
                            , style: homeSubText),

                            Center(child: 
                              FloatingWidget(
                                  seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                  duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                  child: 
                                Transform.scale(scale: 0.65, child: Image.asset(
                                  'assets/cards/Modifiers/Burden.png',
                                   fit: BoxFit.fitWidth,
                                ).animate().boxShadow())
                                ),
                            ),
                            Center(child: 
                              Text('burden'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text(' '
                            , style: homeSubText),
                            Text("With the 'burden' card, your pair attempts will decrease by one on successful pair, and by two otherwise."
                            , style: homeSubText),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),
                            
                            
                            Text(' '
                            , style: homeSubText),

                            Center(child: 
                              FloatingWidget(
                                  seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                  duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                  child: 
                                Transform.scale(scale: 0.65, child: Image.asset(
                                  'assets/cards/Modifiers/Shuffler.png',
                                   fit: BoxFit.fitWidth,
                                ).animate().boxShadow())
                                ),
                            ),
                            Center(child: 
                              Text('shuffler'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text(' '
                            , style: homeSubText),
                            Text("An unsuccessful pair with the 'shuffler' will shuffle the board randomly, as well as adding an extra attempt for your troubles."
                            , style: homeSubText),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),

                             Text(' '
                            , style: homeSubText),

                            Center(child: 
                              FloatingWidget(
                                  seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                  duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                  child: 
                                Transform.scale(scale: 0.65, child: Image.asset(
                                  'assets/cards/Modifiers/Latch.png',
                                   fit: BoxFit.fitWidth,
                                ).animate().boxShadow())
                                ),
                            ),
                            Center(child: 
                              Text('latch'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text(' '
                            , style: homeSubText),
                            Text("When unsuccessfuly pairing a 'latch' card, that card will remain selected until it is paired."
                            , style: homeSubText),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),

                            Text(' '
                            , style: homeSubText),

                            Center(child: 
                              FloatingWidget(
                                  seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                  duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                  child: 
                                Transform.scale(scale: 0.65, child: Image.asset(
                                  'assets/cards/Modifiers/Concealed.png',
                                   fit: BoxFit.fitWidth,
                                ).animate().boxShadow())
                                ),
                            ),
                            Center(child: 
                              Text('concealed'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text(' '
                            , style: homeSubText),
                            Text("A 'concealed' card will never, ever show its value, even through the 'oasis' effect."
                            , style: homeSubText),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),

                            Text(' '
                            , style: homeSubText),

                            Center(child: 
                              FloatingWidget(
                                  seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                  duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                  child: 
                                Transform.scale(scale: 0.65, child: Image.asset(
                                  'assets/cards/Modifiers/Harbinger.png',
                                   fit: BoxFit.fitWidth,
                                ).animate().boxShadow())
                                ),
                            ),
                            Center(child: 
                              Text('harbinger'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text(' '
                            , style: homeSubText),
                            Text("An unsuccessful pair with a 'harbinger' card will give two random cards (with no modifiers) any of the 5 random power downs, including a 'harbinger'"
                            , style: homeSubText),

                            Text(' '
                            , style: homeSubText),

                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),

                            Text(' '
                            , style: homeSubText),
                          
                            Text('Here are the 5 power ups:'
                            , style: homeSubText),

                            Text(' '
                            , style: homeSubText),

                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                children: [

                                   FloatingWidget(
                                            seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                            duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                            child: 
                                          Transform.scale(scale: 0.65, child: Image.asset(
                                            'assets/cards/Modifiers/Prophet.png',
                                             fit: BoxFit.fitWidth,
                                          ).animate().boxShadow())
                                          )
                                ]
                                ),
                                Column(
                                  children: [

                                      FloatingWidget(
                                        seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                        duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                        child:
                                        Stack(alignment: Alignment.center,
                                          children: [
                                            Transform.scale(scale: 0.65, child: Image.asset(
                                              'assets/cards/Values/cardback.png',
                                               fit: BoxFit.fitWidth,
                                            ).animate().boxShadow()),

                                            Transform.scale(scale: 0.65, child: Image.asset(
                                              'assets/cards/Values/propheted.png',
                                               fit: BoxFit.fitWidth,
                                            )
                                            )
                                          ],
                                        )
                                      )
                                    
                                  ]
                                ),
                              ],
                            ),

                            Center(child: 
                              Text('prophet'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text('When successfully pairing a ''Prophet'' card, up to two random powered down cards will permanently be given a mark, shown on the right card, when unselected, signifying that they have a power down modifier. '
                            , style: homeSubText),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),
                            
                            Text(' '
                            , style: homeSubText),

                            Text(' '
                            , style: homeSubText),

                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                children: [

                                   FloatingWidget(
                                            seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                            duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                            child: 
                                          Transform.scale(scale: 0.65, child: Image.asset(
                                            'assets/cards/Modifiers/Telescope.png',
                                             fit: BoxFit.fitWidth,
                                          ).animate().boxShadow())
                                          )
                                ]
                                ),
                                Column(
                                  children: [

                                      FloatingWidget(
                                        seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                        duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                        child:
                                        Stack(alignment: Alignment.topCenter,
                                          children: [
                                            Transform.scale(scale: 0.65, child: Image.asset(
                                              'assets/cards/Values/cardback.png',
                                               fit: BoxFit.fitWidth,
                                            ).animate().boxShadow()),

                                            Transform.scale(
                                              scale: 0.655,
                                              child: Transform.scale(scale: 0.65, child: Image.asset(
                                              'assets/cards/Values/telescoped.png',
                                               fit: BoxFit.fitWidth,
                                            )
                                            )
                                            )

                                            
                                          ],
                                        )
                                      )
                                    
                                  ]
                                ),
                              ],
                            ),

                            Center(child: 
                              Text('telescope'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text("When unsuccessfully pairing a 'Telescope' card, a permanent marking will be shown on half of the total cards that have the same value as the non-telescope selected card."
                            , style: homeSubText),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),

                            Text(' '
                            , style: homeSubText),

                            Center(child: 
                              FloatingWidget(
                                  seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                  duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                  child: 
                                Transform.scale(scale: 0.65, child: Image.asset(
                                  'assets/cards/Modifiers/Bounty.png',
                                   fit: BoxFit.fitWidth,
                                ).animate().boxShadow())
                                ),
                            ),
                            Center(child: 
                              Text('bounty'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text(' '
                            , style: homeSubText),
                            Text("Successfully pairing with a 'Bounty' card will give 3 additional pair attempts."
                            , style: homeSubText),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),

                            Text(' '
                            , style: homeSubText),

                            Center(child: 
                              FloatingWidget(
                                  seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                  duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                  child: 
                                Transform.scale(scale: 0.65, child: Image.asset(
                                  'assets/cards/Modifiers/Oasis.png',
                                   fit: BoxFit.fitWidth,
                                ).animate().boxShadow())
                                ),
                            ),
                            Center(child: 
                              Text('oasis'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text(' '
                            , style: homeSubText),
                            Text("A successful pair with an 'Oasis' card will disable the negative effects of unsuccessfully pairing with a powered down card for two pair attempts."
                            , style: homeSubText),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),

                            Text(' '
                            , style: homeSubText),

                            Center(child: 
                              FloatingWidget(
                                  seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                  duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                  child: 
                                Transform.scale(scale: 0.65, child: Image.asset(
                                  'assets/cards/Modifiers/Cascade.png',
                                   fit: BoxFit.fitWidth,
                                ).animate().boxShadow())
                                ),
                            ),
                            Center(child: 
                              Text('cascade'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text(' '
                            , style: homeSubText),
                            Text("Pairing with a 'Cascade' card successfully will automatically and successfully pair the next selected card. "
                            , style: homeSubText),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),

                            Text(' '
                            , style: homeSubText),
                            






                            
                          ],
                          ),
                        ) 
                       ) ] 
                      
                )
                )
                )
                ]
                )
                )
                
               
        )
               );
               
}
}