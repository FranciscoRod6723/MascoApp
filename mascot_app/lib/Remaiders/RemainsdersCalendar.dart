import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mascot_app/Remaiders/tasks_widget.dart';
import 'package:mascot_app/objects/event.dart';
import 'package:mascot_app/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:http/http.dart' as http;

class HomeRemainders extends StatefulWidget {
  @override
  RemaindersCalendar createState() => RemaindersCalendar();
}

class RemaindersCalendar extends State<HomeRemainders> {

  @override
  void initState() {
    super.initState();

    getRemainders();
  }

  void getRemainders() async{
    Query<Map<String, dynamic>> collectionReference = FirebaseFirestore.instance.collection("remainders_data").where("id_user", isEqualTo: FirebaseAuth.instance.currentUser.uid);
    QuerySnapshot remain = await collectionReference.get();
    if(remain.docs.length != 0){
      for(var doc in remain.docs){
        List data = [doc.data()];

        final event = Event(
        title: data[0]['title'],
        description: data[0]['description'],
        from: DateTime.parse(data[0]['dateFrom']),
        to: DateTime.parse(data[0]['dateTo']),
      );
        final provider = Provider.of<EventProvider>(context, listen: false);
        final events = Provider.of<EventProvider>(context).events;

        if(events.length <= remain.docs.length){
          provider.addEvent(event);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      dataSource: EventDataSouce(events),
      onTap: (details) {
        final provider = Provider.of<EventProvider>(context,listen: false);
        
        provider.setDate(details.date);
        showModalBottomSheet(
          context: context, 
          builder: (context) => TasksWidget(),
        );
      },
    );
  }
}

class EventDataSouce extends CalendarDataSource {
  EventDataSouce(List<Event> appointments){
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments[index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;
  
  @override
  Color getColor(int index) => getEvent(index).background;
}
