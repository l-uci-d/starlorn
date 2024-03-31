import 'dart:html';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:starlorn/global/Animations.dart';
import 'package:starlorn/models/CardGrid.dart';
import 'package:starlorn/models/Mechanics.dart';
import '../global/Globals.dart';
import 'dart:math' as math;


class UsefulMessage extends StatefulWidget {
  const UsefulMessage({super.key});

  @override
  State<UsefulMessage> createState() => _UsefulMessageState();
}


class _UsefulMessageState extends State<UsefulMessage> {
late Game game;
 @override
    void initState() {
        super.initState();         
        game = Game(16, 5, context);                 

    }


  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    homeText = homeText.copyWith(fontSize: screenSize.width * 0.07, fontStyle: FontStyle.italic) ;
    headerTextWhite = headerTextWhite.copyWith(fontSize: screenSize.width * 0.13);
    homeSubText = homeSubText.copyWith(color: darkpurp, fontSize: screenSize.width *0.05);
   
    return MaterialApp(
      home:Scaffold(
      body:         Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_collection.png'),
                fit: BoxFit.fill,
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
                              child: Text('←', style: homeSubText.copyWith(color: whiteish)),
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
                              Text("mechanics"
                            , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            Text(' '
                            , style: homeSubText),
                            Text('Welcome to Starlorn. The goal of the game is to pair all cards in the given grid.', 
                            style: homeSubText,),
                            Text(' '
                            , style: homeSubText),

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
                            crossAxisCount: 4,
                            scrollDirection: Axis.horizontal,
                            childAspectRatio: aspectRatio,

                            children: 
                            List.generate(game.cards.length, (index) {
                              return CardGrid(
                                index: index,
                                card: game.cards[index],
                                onCardPressed: game.onTappedManual,
                              );
                            } )
                          ).animate().fade(duration: .5.seconds, curve: Curves.easeOut).slideY()
                        ),
                      ),    
                    ),

                            Text(' '
                            , style: homeSubText),
                            Text('You match cards by tapping two different cards. Those two cards will then reveal their corresponding value and modifier.', 
                            style: homeSubText,),
                            Text('Their value is represented by one of 48 different possible constellations, a limited number of which are in the board. If their values match, then the two cards will disappear from the board.', 
                            style: homeSubText,),
                            Text('If not, then you will be subtracted one pair attempt, shown as a number at the top of the board. You lose the game when you run out of pair attempts.', 
                            style: homeSubText,),
                            Text('The game also features 10 different modifiers, 5 of which are power ups, and the other 5 are power downs.', 
                            style: homeSubText,),
                            Text('Each has their own unique effects when either paired, selected, or unsuccessfuly paired.', 
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
                                Transform.scale(scale: 0.9, child: Image.asset(
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
                                Transform.scale(scale: 0.9, child: Image.asset(
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
                                Transform.scale(scale: 0.9, child: Image.asset(
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
                                Transform.scale(scale: 0.9, child: Image.asset(
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
                                Transform.scale(scale: 0.9, child: Image.asset(
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

                            Center(child:
                              Column(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                   FloatingWidget(
                                            seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                            duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                            child: 
                                          Transform.scale(scale: 0.9, child: Image.asset(
                                            'assets/cards/Modifiers/Prophet.png',
                                             fit: BoxFit.fitWidth,
                                          ).animate().boxShadow())
                                          )
                                ]
                                ),
                                Row(mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                      FloatingWidget(
                                        seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                        duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                        child:
                                        Stack(alignment: Alignment.center,
                                          children: [
                                            Transform.scale(scale: 0.9, child: Image.asset(
                                              'assets/cards/Values/cardback.png',
                                               fit: BoxFit.fitWidth,
                                            ).animate().boxShadow()),

                                            Transform.scale(scale: 0.9, child: Image.asset(
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
                            ),

                            Center(child: 
                              Text('prophet'
                              , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            ),
                            Text('When successfully pairing a ''Prophet'' card, up to two random powered down cards will permanently be given a mark when unselected, signifying that they have a power down modifier. '
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

                            Center(child:
                              Column(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                   FloatingWidget(
                                            seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                            duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                            child: 
                                          Transform.scale(scale: 0.9, child: Image.asset(
                                            'assets/cards/Modifiers/Telescope.png',
                                             fit: BoxFit.fitWidth,
                                          ).animate().boxShadow())
                                          )
                                ]
                                ),
                                Row(mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                      FloatingWidget(
                                        seed: (math.Random().nextDouble() * 2.0) - 2.0,
                                        duration: Duration(seconds: math.Random().nextInt(10) + 5),
                                        child:
                                        Stack(alignment: Alignment.topCenter,
                                          children: [


                                            Transform.scale(scale: 0.9, child: Image.asset(
                                              'assets/cards/Values/cardback.png',
                                               fit: BoxFit.fitWidth,
                                            ).animate().boxShadow()),
                                            Transform.scale(scale: 0.4, child: Image.asset(
                                              'assets/cards/Values/telescoped.png',
                                               fit: BoxFit.cover,
                                            )
                                            ),
                                          ],
                                        )
                                      )
                                    
                                  ]
                                ),
                              ],
                            ),
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
                                Transform.scale(scale: 0.9, child: Image.asset(
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
                                Transform.scale(scale: 0.9, child: Image.asset(
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
                                Transform.scale(scale: 0.9, child: Image.asset(
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
                            Text("Pairing with a 'Cascade' card successfully will automatically and successfully pair the next selected card."
                            , style: homeSubText),
                            const Divider(
                              color: magenta,
                              thickness: 3.5,
                              height: 1
                            ),


                            Text("scoring"
                            , style: headerTextWhite.copyWith(color: Colors.black, fontSize: screenSize.width * 0.055)),
                            Text(" "
                            , style: homeSubText),
                            Text("Each successful pair will give the player 100 points multiplied by the current mult."
                            , style: homeSubText),
                            Text("The current mult will be doubled when the player matches cards with the same value as the last matched card."
                            , style: homeSubText),
                            Text("When the game is finished, the final multiplier, attempts remaning, and the time score will be added, to which the sum is multiplied to the last score displayed on the top right."
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