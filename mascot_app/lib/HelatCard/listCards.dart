import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/HealtCardFuntios.dart';
import 'package:mascot_app/HelatCard/HealtCard.dart';
import 'package:mascot_app/objects/cards.dart';
import 'package:provider/provider.dart';

class ListCards extends StatefulWidget {
  const ListCards({ Key key }) : super(key: key);

  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<ListCards> {
  @override
  Widget build(BuildContext context) {
    HCServices _hcService = HCServices();
    _hcService.getCards();
    List<Cards> cardsData = Provider.of<List<Cards>>(context) ?? []; 
    return ListView.builder(
      itemCount: cardsData.length,
      itemBuilder: (context, index) {
        final card = cardsData[index];
        return HomeHealtCards(cardData: card, idp: card.id);
      },
    );
  }
}