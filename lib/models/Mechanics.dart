import 'package:flutter/material.dart';

import 'Cards.dart';
import 'dart:math';

class Game {
  Game(this.gridSize) {
    generateCards();
  }
  final int gridSize;

  List<Cards> cards = [];
  bool isGameOver = false;

  void generateCards() {
    cards = [];
    for (int i = 1; i < (gridSize * gridSize / 2) + 1; i++) {
      final String path = '$i';
      final cardValue = i + 1;

      final List<Cards> newCards = _createCards(path, cardValue);
      cards.addAll(newCards);
    }
    cards.shuffle(Random());
  }


List<Cards> _createCards(String path, int cardValue) {
    return List.generate(2,
      (index) => Cards(
        value: cardValue,
        spritePath: path,
      ),
    );
  }

void onTapped(int index){
  cards[index].state = CardState.selected;
    final List<int> visibleCardIndexes = _getVisibleCardIndexes();
    if (visibleCardIndexes.length == 2) {
      final Cards card1 = cards[visibleCardIndexes[0]];
      final Cards card2 = cards[visibleCardIndexes[1]];
      if (card1.value == card2.value) {
        card1.state = CardState.paired;
        card2.state = CardState.paired;
        isGameOver = _isGameOver();
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          if(card1.modifiers != Modifiers.Latch) {
            card1.state = CardState.hidden;
          }

          if(card2.modifiers != Modifiers.Latch) {
            card2.state = CardState.hidden;
          }
        });
      }
    }
  }

  List<int> _getVisibleCardIndexes() {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.state == CardState.selected)
        .map((entry) => entry.key)
        .toList();
  }


  bool _isGameOver() {
    return cards.every((card) => card.state == CardState.paired);
  }


}