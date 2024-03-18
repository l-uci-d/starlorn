
import 'dart:async';

import 'package:flutter/material.dart';
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
        child: Stack(
            children: <Widget>[
                if(card.state == CardState.hidden)
                  Image.asset(
                  'assets/cards/cardback.png', 
                  fit: BoxFit.fitWidth ,
                )
                else if(card.state == CardState.selected)
                Stack(
                  children: <Widget>[
                    Image.asset(
                      'assets/cards/Modifiers/${card.modifierPath.toString().split('.').last}.png', 
                      fit: BoxFit.fitWidth ,
                    ),
                      Image.asset(
                      'assets/cards/${card.spritePath}.png', 
                      fit: BoxFit.fitWidth ,
                    )



                  ]
                  
                )

                
                    
                else if(card.state == CardState.paired)
                Image.asset(
                  'assets/cards/matched.png', 
                  fit: BoxFit.fitWidth ,
                )
                

            ],

        )
          
      

    );
  }


  
}