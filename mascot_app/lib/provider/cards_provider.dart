import 'package:flutter/cupertino.dart';
import 'package:mascot_app/objects/cards.dart';

class CardProvider extends ChangeNotifier {
  final List<Cards> _cards = [];

  List<Cards> get cards => _cards;

  List<Cards> get eventsOfSelectedDate => _cards;

  void addEvent(Cards card){
    _cards.add(card);

    notifyListeners();
  }

  void deleteEvent(Cards card){
    _cards.remove(card);

    notifyListeners();
  }

  void editEvent(Cards newCard, Cards oldCard){
    final index = _cards.indexOf(oldCard);
    _cards[index] = newCard; 

    notifyListeners();
  }
}