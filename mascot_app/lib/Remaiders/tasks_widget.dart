import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mascot_app/Remaiders/RemaindersView.dart';
import 'package:mascot_app/Remaiders/RemainsdersCalendar.dart';
import 'package:mascot_app/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TasksWidget extends StatefulWidget{
  @override 
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TasksWidget>{
  @override 
  Widget build(BuildContext context){
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if(selectedEvents.isEmpty){
      return Center(
        child: Text(
          'No events found',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      );
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: TextStyle(fontSize: 16, color: Colors.black)
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSouce(provider.events),
        initialDisplayDate: provider.seletedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        selectionDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3)
        ),
        onTap: (details){
          if (details.appointments == null) return;

          final event = details.appointments.first;

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RemainderViewPage(event:event)
          ));
        },
      ),
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ){
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.width,
      decoration: BoxDecoration(
        color: event.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12) 
      ),
      child: Center( 
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    );
  }
}