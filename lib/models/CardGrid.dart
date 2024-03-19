
// ignore_for_file: unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../global/Globals.dart';
import 'Cards.dart';

class CardGrid extends StatelessWidget{
  CardGrid({
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
        child: Column(
            children: <Widget>[
              

                if(card.state == CardState.hidden)
                  Stack(
                    children: <Widget>[
                        Image.asset(
                          'assets/cards/Values/cardback.png', 
                          fit: BoxFit.fitWidth
                        ),
                        if(card.propheted)
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
                      
                    Image.asset(
                      'assets/cards/Modifiers/${card.modifierPath.toString().split('.').last}.png', 
                      fit: BoxFit.fitHeight ,
                    ),

                    if(card.modifiers!= Modifiers.Concealed)
                        Positioned.fill(
                        child: Align(
                        alignment: Alignment.center,
                        child:
                        Image.asset(
                            'assets/cards/Values/${card.spritePath}.png', 
                            fit: BoxFit.fitWidth
                          )
                          ,)
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
    ;
  }
}