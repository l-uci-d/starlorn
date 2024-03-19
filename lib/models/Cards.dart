
// ignore_for_file: constant_identifier_names

enum CardState {hidden, paired, selected}

enum Modifiers {Base, Latch, Concealed, Harbinger, Burden, 
Shuffler, Oasis, Bounty, Prophet, Telescope, Cascade}

List<Modifiers> nonBaseModifiers = [Modifiers.Latch, Modifiers.Concealed, Modifiers.Harbinger, Modifiers.Burden, 
Modifiers.Shuffler, Modifiers.Oasis, Modifiers.Bounty, Modifiers.Prophet, Modifiers.Telescope, Modifiers.Cascade];

List<Modifiers> powerDowns = [Modifiers.Latch, Modifiers.Concealed, Modifiers.Harbinger, Modifiers.Burden, 
Modifiers.Shuffler];



class Cards{

  Cards({
    required this.value,
    required this.spritePath,
    this.state = CardState.hidden,
    this.modifiers = Modifiers.Base,
    this.propheted = false,
    this.telescoped = false,

  }) {
    _updateModifierPath();
  }

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