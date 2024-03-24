

import 'package:flutter/material.dart';
import '../global/Globals.dart';
import '../screens/play.dart';
import '../widgets/AlertDialogs.dart';
import 'Cards.dart';
import 'dart:math';

class Collection {
  Collection(this.context) {
    generateCollection();
  }

  List<CardsCollection> CollectionCards = [];
  BuildContext context;

  void generateCollection() {
 
    for (int i = 0; i < 48; i++) {
    final String path = '${i+1}'; 
    final List<CardsCollection> newValues = _createCards(path, i);
    
    CollectionCards.addAll(newValues);
  }
}

List<CardsCollection> _createCards(String path, int cardValue) {
  return List.generate(1, (index) => CardsCollection(
    value: cardValue,
    spritePath: path,
    modifierPath: 'Base'
  ));
}

void onTapped(int index){

}

}