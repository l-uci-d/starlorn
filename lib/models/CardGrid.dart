
// ignore_for_file: unused_import

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:starlorn/global/Animations.dart';
import 'package:starlorn/models/Mechanics.dart';
import '../global/Globals.dart';
import 'Cards.dart';

class CardGrid extends StatelessWidget{
  const CardGrid({
    required this.card,
    required this.index,
    required this.onCardPressed,


    super.key
  });

  final Cards card;
  final int index;
  final ValueChanged<int> onCardPressed;

  void _handleCardTap() {
    if (card.state == CardState.hidden) {
      Timer(const Duration(milliseconds: 100), () {
        onCardPressed(index);
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    
    return InkWell(
      onTap: _handleCardTap,
      child: FloatingWidget(
        seed: (math.Random().nextDouble() * 2.0) - 2.0,
        duration: Duration(seconds: math.Random().nextInt(10) + 3),

        child: Column(
            children: <Widget>[
                if(card.state == CardState.hidden)
                  Stack(
                    children: <Widget>[
                      
                        Image.asset('assets/cards/Values/matched.png').animate().boxShadow(),
                        //Image.asset(
                        
                         // 'assets/cards/Values/cardback.png', 
                         // fit: BoxFit.contain
                       // ),
                        Image.asset(
                        'assets/cards/Modifiers/${card.modifierPath.toString().split('.').last}.png',
                         // 'assets/cards/Values/cardback.png', 
                          fit: BoxFit.contain
                        ),
                        Image.asset(
                                'assets/cards/Values/${card.spritePath}.png', 
                                fit: BoxFit.fitWidth
                              ),

                        if(card.propheted)
                        Animate(
                          effects: 
                          [
                            FadeEffect(begin: 0.4, end: 1,
                              duration: 0.75.seconds),

                            ScaleEffect(duration: 0.75.seconds, begin: const Offset(5, 5), 
                              end: const Offset(1, 1), curve: Curves.bounceOut),
                        ],
                          child:
                          Transform.scale(
                          scale: 0.85,
                          child: 
                            Image.asset(
                              'assets/cards/Values/propheted.png', 
                            )
                          )
                        ),

                        if(card.telescoped)
                        Animate(
                          effects: 
                          [
                            FadeEffect(begin: 0.4, end: 1,
                              duration: 0.75.seconds),

                            ScaleEffect(duration: 0.75.seconds, begin: const Offset(5, 5), 
                              end: const Offset(1, 1), curve: Curves.easeInExpo),
                        ],
                          child:
                          Transform.scale(
                          scale: 0.85,
                          child: 
                            Image.asset(
                              'assets/cards/Values/telescoped.png', 
                              fit: BoxFit.fitHeight
                            )
                          )
                        )
                      ]
                    )
                   
                else if(card.state == CardState.selected)
                  Stack(
                    children: <Widget>[

                      Image.asset('assets/cards/Values/matched.png'),

                      Stack (children:<Widget>[

                        Image.asset(
                        'assets/cards/Modifiers/${card.modifierPath.toString().split('.').last}.png', 
                        fit: BoxFit.fitHeight ,
                      ).animate().boxShadow(begin:BoxShadowEffect.neutralValue, duration: 100.milliseconds)
                      ,
                      if(card.modifiers!= Modifiers.Concealed)
                          Positioned.fill(
                          child: Align(
                          alignment: Alignment.center,
                          child:
                          Transform.scale(
                            scale: 0.75,
                            child: (
                  
                              Image.asset(
                                'assets/cards/Values/${card.spritePath}.png', 
                                fit: BoxFit.fitWidth
                              )
                            )
                          )
                          )
                          )
                          ].animate().flipH(begin: 1.0, end:2.0,
                   duration:100.milliseconds).slideY(duration: 100.milliseconds, begin:0, end: -0.3)
                          )
                    ]
                  )

                else if(card.state == CardState.paired)
                Image.asset(
                  'assets/cards/Values/matched.png', 
                  fit: BoxFit.fitWidth ,
                )
            ],
        )
        )
    )
    ;
  }
}