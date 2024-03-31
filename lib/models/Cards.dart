
// ignore_for_file: constant_identifier_names

import 'dart:convert';

enum CardState {hidden, paired, selected}

enum Modifiers {Base, Latch, Concealed, Harbinger, Burden, 
Shuffler, Oasis, Bounty, Prophet, Telescope, Cascade}

List<Modifiers> nonBaseModifiers = [Modifiers.Latch, Modifiers.Concealed, Modifiers.Harbinger, Modifiers.Burden, 
Modifiers.Shuffler, Modifiers.Oasis, Modifiers.Bounty, Modifiers.Prophet, Modifiers.Telescope, Modifiers.Cascade];

List<Modifiers> powerDowns = [Modifiers.Latch, Modifiers.Concealed, Modifiers.Harbinger, Modifiers.Burden, 
Modifiers.Shuffler];



class CardsGame{

  CardsGame({
    required this.value,
    required this.spritePath,
    this.state = CardState.hidden,
    this.modifiers = Modifiers.Base,
    this.propheted = false,
    this.telescoped = false,
    this.active = false

  }) {
    _updateModifierPath();
  }
  bool active;
  final int value;
  CardState state;
  final String spritePath;
  Modifiers modifiers;
  String modifierPath = '';
  bool propheted;
  bool telescoped;

  void _updateModifierPath() {
    modifierPath = modifiers.toString();
  }
  void setModifier(Modifiers newModifier) {
    modifiers = newModifier;
    _updateModifierPath();
  }
}

class CardsManual{

  CardsManual({
    required this.value,
    required this.spritePath,
    this.state = CardState.selected,
    this.modifiers = Modifiers.Base,
    this.propheted = false,
    this.telescoped = false,
    this.active = false

  }) {
    _updateModifierPath();
  }
  bool active;
  final int value;
  CardState state;
  final String spritePath;
  Modifiers modifiers;
  String modifierPath = '';
  bool propheted;
  bool telescoped;

  void _updateModifierPath() {
    modifierPath = modifiers.toString();
  }
  void setModifier(Modifiers newModifier) {
    modifiers = newModifier;
    _updateModifierPath();
  }
}


class CardsCollection {
  CardsCollection({
    required this.value,
    required this.spritePath,
    required this.modifierPath,
    this.active = false,
  });

  bool active;
  final int value;
  final String modifierPath;
  final String spritePath;


}


