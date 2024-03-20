

import '../screens/play.dart';
import 'Cards.dart';
import 'dart:math';

Random random = Random();
class Game {
  Game(this.cardAmt, this.unique) {
    generateCards();
  }
  final int cardAmt;
  final int unique;

  List<Cards> cards = [];
  List<int> values = [];
  List<int> uniqueLeft =[];
  List<Cards> forProphet = [];
  bool isGameOver = false;
  bool isGameWon = false;
  bool cascading = false;

  int oasis = 0;

  void generateCards() {
    Random random = Random();

    for(int u = 1; u <= unique; u++){
      values.add(random.nextInt(9) + 1);
      uniqueLeft.add(0);
    }
    values.shuffle();
    print('values = $values');

    int index = 0;
    for (int i = 1; i <= cardAmt/2; i++) {
      final cardValue = values[index];
      uniqueLeft[index]+=1;
      
      final String path = '$cardValue';
      final List<Cards> newCards = _createCards(path, cardValue);
      for(var card in newCards){
          int randomChance = Random().nextInt(100);
        if (randomChance <= 35) {
            int randomIndex = Random().nextInt(nonBaseModifiers.length);
            card.setModifier(nonBaseModifiers[randomIndex]);
            if(powerDowns.contains(card.modifiers))
              {
                forProphet.add(card);
              }
            print(card.modifiers);
        }
      }
      cards.addAll(newCards);

      index = (index + 1) % values.length; 
    }
    print('count = $uniqueLeft');
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
  bool Oasis = oasis == 0;
  cards[index].state = CardState.selected;
  if(cascading){
    cascade(cards[index]);
  }
    
    final List<int> visibleCardIndexes = _getCardIndexes(CardState.selected);
    
    if (visibleCardIndexes.length %2 == 0) {
      final Cards card1 = cards[visibleCardIndexes[0]];
      final Cards card2 = cards[visibleCardIndexes[1]];

      bool match = card1.value == card2.value;


      if (match) {
        Future.delayed(const Duration(milliseconds: 500), () {

          isGameOver = _isGameOver();
          isGameWon = _isGameWon();

          if(lastPair == card1.spritePath){
            mult*=2;
          }

          score += (100*mult);

          lastPair = card1.spritePath;
          forProphet.remove(card1);
          forProphet.remove(card2);
          
          Mods(card1, card2, match, Oasis);
          card1.state = CardState.paired;
          card2.state = CardState.paired;

          _updateUniqueCount(card1.value);

        });
        
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {

        attempts -=1;
          

          if(card1.modifiers != Modifiers.Latch && card1.state != CardState.paired) {
            card1.state = CardState.hidden;
          }

          if(card2.modifiers != Modifiers.Latch  || card1.modifiers == Modifiers.Latch && card2.state != CardState.paired) {
            card2.state = CardState.hidden;
          }

          for (int i = 0; i < visibleCardIndexes.length - 1; i++) {
            if(cards[i].state != CardState.paired && i%2 == 0 && cards[i].modifiers != Modifiers.Latch)
              {cards[i].state = CardState.hidden;
     //         print('${cards[i].value}  hidden');
              }
          Mods(card1, card2, match, Oasis);
          }
        });
       
      }
    }
  }

  void Mods(Cards card1, Cards card2, bool match, bool oasis){
    Modifiers mod1 = card1.modifiers, mod2 = card2.modifiers;

    attempts -= (mod1 == Modifiers.Burden ? 1 : 0) + (mod2 == Modifiers.Burden ? 1 : 0);

    if(!match){
        

        if(mod1 == Modifiers.Telescope || mod2 == Modifiers.Telescope){
          Cards telescopeCard = mod1 == Modifiers.Telescope ? card2 : card1;
            List<int> telescopeIndexes = _getPairs(telescopeCard.value);
            for(var x in telescopeIndexes){
              cards[x].telescoped = true;
            }
        }

        if(mod1 == Modifiers.Shuffler || mod2 == Modifiers.Shuffler){
          Cards shuffler = mod1 == Modifiers.Shuffler ? card1 : card2;
          Cards temp;
          print('Shuffling ${shuffler.modifiers}');
            List<int> shuffle = _getCardIndexes(CardState.hidden);
            shuffle.shuffle();
            print(shuffle);
            
            print(_getModifiedCards(Modifiers.Shuffler));
            temp = cards[shuffle[0]];
            cards[shuffle[0]] = shuffler;
            shuffler = temp;
            print(_getModifiedCards(Modifiers.Shuffler));

        }

        if(mod1 == Modifiers.Harbinger || mod2 == Modifiers.Harbinger){
          List<int> indices = _getUnspecialUnpaired();
          if(indices.isNotEmpty){
            indices.shuffle();
            print('Harbinger: $indices');
            int randomIndex = Random().nextInt(powerDowns.length);
            cards[indices[0]].setModifier(powerDowns[randomIndex]);
            randomIndex = Random().nextInt(powerDowns.length);
            cards[indices[1]].setModifier(powerDowns[randomIndex]);

          }
        }
    }


    else{
        attempts += (mod1 == Modifiers.Bounty ? 3 : 0) + (mod2 == Modifiers.Bounty ? 3 : 0);

        if((mod1 == Modifiers.Prophet || mod2 == Modifiers.Prophet) && forProphet.isNotEmpty){
          forProphet.shuffle();
            forProphet[0].propheted = true;
        }

        if(mod1 == Modifiers.Cascade || mod2 == Modifiers.Cascade){
          if(mod1 != mod2){
            cascade(null);
          print(cascading);
          }
          else{
            cascade(null);
            cascading = true;
          }
          
        }



      }
      
  }


void _updateUniqueCount(int val){
    uniqueLeft[values.indexOf(val)]--;
    if(uniqueLeft[values.indexOf(val)] == 0){
      uniquePairs-=1;
    }
    print('count = $uniqueLeft');
}
  

List<int> _getUnspecialUnpaired( ) {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.state == CardState.hidden
        && !nonBaseModifiers.contains(entry.value.modifiers) 
        )


        .map((entry) => entry.key)
        .toList();
  }


  void cascade(Cards? card){
      if(!cascading){
          cascading = true;
          return;
      }
      else{
          List<int> toCascadeIndexes = _getPairs(card!.value);
          toCascadeIndexes.shuffle();
          print(toCascadeIndexes);
          cascading = false;
          onTapped(toCascadeIndexes[0]);
          
      }
  }

  List<int> _getPairs(int value) {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.state != CardState.paired && entry.value.value == value
        && entry.value.state != CardState.selected
        )


        .map((entry) => entry.key)
        .toList();
  }

    List<int> _getModifiedCards(Modifiers state) {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.modifiers == state)
        .map((entry) => entry.key)
        .toList();
  }

  

  List<int> _getCardIndexes(CardState state) {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.state == state)
        .map((entry) => entry.key)
        .toList();
  }


  bool _isGameWon() {
    return cards.every((card) => card.state == CardState.paired);
    
  }

bool _isGameOver(){
  if (!isGameWon && attempts == 0) {
    print('GameOVER');
    return true;
  }
  return false;
}

}