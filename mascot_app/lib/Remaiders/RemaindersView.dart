import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mascot_app/Remaiders/AddRemainder.dart';
import 'package:mascot_app/objects/event.dart';
import 'package:mascot_app/provider/event_provider.dart';
import 'package:provider/provider.dart';

class RemainderViewPage extends StatelessWidget {
  final Event event;

  const RemainderViewPage({
    Key key,
    this.event,
  }) : super(key: key);

  @override 
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.greenDefault,
      leading: CloseButton(),
      actions: buildViewingActions(context,event),
    ),
    body: ListView(
      padding: EdgeInsets.all(32),
      children: <Widget>[
        Text(
          event.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height:32),
        buildDateTime(event),
        SizedBox(height: 32,),
        Text(
          "Description",
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20,),
        Text(
          event.description,
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
        ),       
      ],
    ),
  );

  Widget buildDateTime(Event event){
    return Column(
      children: [
        buildDate('From', event.from),
        buildDate('To', event.to)
      ],
    );
  }
  
  Widget buildDate(String title, DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd – HH:mm').format(date);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(title, style: TextStyle(fontSize:18),)
        ),
        Expanded(
          child: Text(formattedDate, style: TextStyle(fontSize:18),)
        )
      ],
    );
  } 

  List<Widget> buildViewingActions(BuildContext context, Event event) => [
    IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AddRemainders(event: event),
        )
      ),
    ),
    IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        final provider = Provider.of<EventProvider>(context, listen: false);
        provider.deleteEvent(event);

        Navigator.of(context).pop();
      }
    ),
  ];
}