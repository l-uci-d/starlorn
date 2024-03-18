
// ignore_for_file: constant_identifier_names

enum CardState {hidden, paired, selected}
enum Modifiers {Base, Latch, Concealed, Harbinger, Burden, 
Shuffler, Oasis, Bounty, Prophet, Telescope, Cascade}

class Cards{

  Cards({
    required this.value,
    required this.spritePath,
    this.state = CardState.hidden,
    this.modifiers = Modifiers.Base

  }) {
    _updateModifierPath();
  }

  final int value;
  CardState state;
  final String spritePath;
  Modifiers modifiers;
  String modifierPath = '';

  void _updateModifierPath() {
    modifierPath = modifiers.toString();
  }
}